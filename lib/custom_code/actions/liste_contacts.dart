// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart'; // Importer Firestore
import 'package:fast_contacts/fast_contacts.dart'; // Importer les contacts
import 'package:permission_handler/permission_handler.dart'; // Gestion des permissions

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ContactsPage extends StatefulWidget {
  final String contactsJson;
  ContactsPage({required this.contactsJson});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    loadContacts(); // Charger les contacts au démarrage
  }

  void loadContacts() async {
    final String? contactsJson = widget.contactsJson;
    // Vider la liste avant de charger
    maListeDeContacts.clear();
    if (contactsJson != null) {
      try {
        List<dynamic> loadedContacts = jsonDecode(contactsJson);
        maListeDeContacts = List<Map<String, String>>.from(loadedContacts);
      } catch (e) {
        print('Erreur lors du chargement des contacts : $e');
      }
    }
  }

  Future<void> _addContactToFirestore(String name, String phone) async {
    if (phone.isNotEmpty) {
      await _firestore.collection('myContacts').doc(name).set({
        'name': name,
        'phone': phone,
      });
    }
  }

  Future<void> _removeContactFromFirestore(String name) async {
    await _firestore.collection('myContacts').doc(name).delete();
  }

  Future<bool> _isContactInFirestore(String name) async {
    var doc = await _firestore.collection('myContacts').doc(name).get();
    return doc.exists;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> contactsList = jsonDecode(widget.contactsJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
      ),
      body: ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          var contact = contactsList[index];
          bool isInList = maListeDeContacts
              .any((c) => c['displayName'] == contact['displayName']);

          // Vérifier si le contact est déjà dans Firestore
          bool isInFirestore = false;

          // Utilisation d'un FutureBuilder pour vérifier la présence du contact
          return FutureBuilder<bool>(
            future: _isContactInFirestore(contact['displayName']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              isInFirestore = snapshot.data ?? false;

              // Récupérer le premier numéro mobile valide
              String phone = _getFirstMobileNumber(contact['phones']);

              return ListTile(
                title: Text(contact['displayName']),
                subtitle: Text(
                    'Phone: $phone'), // Afficher uniquement le premier numéro mobile valide
                trailing: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (isInFirestore) {
                        // Si le contact est déjà dans Firestore, le supprimer
                        _removeContactFromFirestore(contact['displayName']);
                      } else {
                        // Ajouter le contact s'il n'existe pas déjà
                        _addContactToFirestore(contact['displayName'], phone);
                      }
                      loadContacts(); // Recharge les contacts après modification
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInFirestore ? Colors.red : Colors.blue,
                  ),
                  child: Text(isInFirestore ? 'Supprimer' : 'Ajouter'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(); // Retour à la page précédente
        },
        child: Icon(Icons.check),
      ),
    );
  }

  // Fonction pour obtenir le premier numéro mobile valide
  String _getFirstMobileNumber(List<dynamic> phones) {
    for (var phone in phones) {
      String number = phone.number;
      if (number.startsWith('+337') ||
          number.startsWith('+336') ||
          number.startsWith('06') ||
          number.startsWith('07')) {
        return number; // Retourner le numéro valide
      }
    }
    return ''; // Retourne une chaîne vide si aucun mobile trouvé
  }
}

Future<void> listeContacts(BuildContext context) async {
  List<Map<String, dynamic>> contactsList = [];

  // Vérifier et demander les permissions
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus != PermissionStatus.granted) {
    // Si les permissions ne sont toujours pas accordées, quitter
    return;
  }

  try {
    // Récupérer les contacts après que les permissions aient été accordées
    List<Contact> contacts = await FastContacts.getAllContacts();
    for (var contact in contacts) {
      contactsList.add({
        'displayName': contact.displayName,
        'phones': contact.phones,
        'emails': contact.emails.map((e) => e.address).toList(),
      });
    }

    String contactsJson = jsonEncode(contactsList);
    // Naviguer vers la page cible en passant le JSON
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contactsJson: contactsJson),
      ),
    );
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}

// Fonction pour vérifier et demander les permissions
Future<PermissionStatus> _getContactPermission() async {
  // Vérifier si la permission a déjà été accordée
  var status = await Permission.contacts.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    // Demander à l'utilisateur s'il a refusé ou refusé de façon permanente
    PermissionStatus newStatus = await Permission.contacts.request();
    if (newStatus.isPermanentlyDenied) {
      // Si refus permanent, ouvrir les paramètres pour l'autoriser manuellement
      await openAppSettings();
    }
    return newStatus;
  }
  return status;
}
