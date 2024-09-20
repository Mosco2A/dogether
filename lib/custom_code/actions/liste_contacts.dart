// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:fast_contacts/fast_contacts.dart'; // Importer les contacts
import 'package:permission_handler/permission_handler.dart'; // Gestion des permissions

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];

class ContactsPage extends StatelessWidget {
  final String contactsJson;

  ContactsPage({required this.contactsJson});

  @override
  Widget build(BuildContext context) {
    List<dynamic> contactsList = jsonDecode(contactsJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
      ),
      body: ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          var contact = contactsList[index];

          // Vérifiez si le contact est déjà dans la liste
          bool isInList = maListeDeContacts
              .any((c) => c['displayName'] == contact['displayName']);

          return ListTile(
            title: Text(contact['displayName']),
            subtitle: Text('Phones: ${contact['phones'].join(', ')}'),
            trailing: ElevatedButton(
              onPressed: () {
                if (isInList) {
                  // Si le contact est déjà dans la liste, le supprimer
                  maListeDeContacts.removeWhere(
                      (c) => c['displayName'] == contact['displayName']);
                } else {
                  // Ajouter le contact s'il n'existe pas déjà
                  maListeDeContacts.add({
                    'displayName': contact['displayName'],
                    'phones': contact['phones'].join(', '),
                  });
                }
                // Rebuild the UI to reflect changes
                (context as Element).reassemble();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isInList ? Colors.red : Colors.blue, // Changement ici
              ),
              child: Text(isInList ? 'Enlever' : 'Ajouter'),
            ),
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

  try {
    var permissionStatus = await Permission.contacts.request();
    if (permissionStatus != PermissionStatus.granted) {
      return; // Permission refusée, rien à faire
    }

    List<Contact> contacts = await FastContacts.getAllContacts();
    for (var contact in contacts) {
      contactsList.add({
        'displayName': contact.displayName,
        'phones': contact.phones.map((e) => e.number).toList(),
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
