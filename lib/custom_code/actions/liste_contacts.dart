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
import 'dart:convert'; // Pour jsonDecode et jsonEncode

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

  // Ajoute le contact à Firestore avec un identifiant aléatoire
  Future<void> _addContactToFirestore(String name, String phone) async {
    String docId = _firestore.collection('myContacts').doc().id; // ID aléatoire
    await _firestore.collection('myContacts').doc(docId).set({
      'name': name,
      'phone': phone,
    });
  }

  // Supprime un contact de Firestore en utilisant son ID de document
  Future<void> _removeContactFromFirestore(String docId) async {
    await _firestore.collection('myContacts').doc(docId).delete();
  }

  // Récupère l'ID du document correspondant au nom du contact
  Future<String?> _getContactDocId(String name) async {
    var querySnapshot = await _firestore
        .collection('myContacts')
        .where('name', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id; // Retourne l'ID du document
    }
    return null; // Aucun document trouvé
  }

  String formatPhoneNumber(String phone) {
    // Supprimer tous les espaces avant tout traitement
    phone = phone.replaceAll(' ', '');

    // Appliquer les règles de formatage des numéros français
    if (phone.startsWith('06')) {
      return '+33(6)' + phone.substring(2);
    } else if (phone.startsWith('07')) {
      return '+33(7)' + phone.substring(2);
    } else if (phone.startsWith('+336')) {
      return phone.replaceFirst('+336', '+33(6)');
    } else if (phone.startsWith('+337')) {
      return phone.replaceFirst('+337', '+33(7)');
    }

    return phone; // Retourne le numéro sans espaces et formaté
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

          return FutureBuilder<String?>(
            future: _getContactDocId(contact['displayName']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              String? docId = snapshot.data;
              bool isInFirestore = docId != null;

              return ListTile(
                title: Text(contact['displayName']),
                subtitle: Text('Phone: $formattedPhone'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (isInFirestore) {
                        // Si le contact est déjà dans Firestore, le supprimer
                        _removeContactFromFirestore(docId!);
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

// Fonction pour lister les contacts et naviguer vers la page de contacts
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

// Fonction pour vérifier et demander les permissions de contacts
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
