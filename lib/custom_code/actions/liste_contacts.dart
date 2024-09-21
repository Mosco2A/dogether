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
    await _firestore.collection('myContacts').doc(name).set({
      'name': name,
      'phone': phone,
    });
  }

  Future<void> _removeContactFromFirestore(String name) async {
    await _firestore.collection('myContacts').doc(name).delete();
  }

  Future<bool> _isContactInFirestore(String name) async {
    var doc = await _firestore.collection('myContacts').doc(name).get();
    return doc.exists;
  }

  String formatPhoneNumber(String phone) {
    // Transformer le numéro de téléphone au format +33(7)82644001
    if (phone.startsWith('06')) {
      return '+33(6)' + phone.substring(2);
    } else if (phone.startsWith('07')) {
      return '+33(7)' + phone.substring(2);
    } else if (phone.startsWith('+336')) {
      return phone.replaceFirst('+336', '+33(6)');
    } else if (phone.startsWith('+337')) {
      return phone.replaceFirst('+337', '+33(7)');
    }
    return phone; // Retourne le numéro tel quel si aucun format ne correspond
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
          List<String> validPhones = (contact['phones'] as List<dynamic>)
              .where((phone) =>
                  phone.startsWith('+337') ||
                  phone.startsWith('+336') ||
                  phone.startsWith('06') ||
                  phone.startsWith('07'))
              .map((phone) => phone.toString()) // Convertir en String
              .toList();

          // Ne pas afficher le contact s'il n'a pas de numéro valide
          if (validPhones.isEmpty) {
            return SizedBox.shrink(); // Ne rien afficher
          }

          String phoneToSave =
              validPhones.first; // Prendre le premier numéro valide
          String formattedPhone =
              formatPhoneNumber(phoneToSave); // Formater le numéro

          return FutureBuilder<bool>(
            future: _isContactInFirestore(contact['displayName']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              bool isInFirestore = snapshot.data ?? false;

              return ListTile(
                title: Text(contact['displayName']),
                subtitle: Text('Phone: $formattedPhone'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (isInFirestore) {
                        // Si le contact est déjà dans Firestore, le supprimer
                        _removeContactFromFirestore(contact['displayName']);
                      } else {
                        // Ajouter le contact s'il n'existe pas déjà
                        _addContactToFirestore(
                            contact['displayName'], formattedPhone);
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
      // Extraire uniquement les numéros de téléphone
      List<String> phoneNumbers = contact.phones.map((e) => e.number).toList();

      contactsList.add({
        'displayName': contact.displayName,
        'phones': phoneNumbers, // Remplacer par une liste de chaînes
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
