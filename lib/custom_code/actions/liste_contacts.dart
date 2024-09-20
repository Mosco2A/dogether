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
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];

class ContactsPage extends StatefulWidget {
  final String contactsJson;

  ContactsPage({required this.contactsJson});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
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
          // Vérifiez si le contact est déjà dans la liste
          bool isInList = maListeDeContacts
              .any((c) => c['displayName'] == contact['displayName']);

          return ListTile(
            title: Text(contact['displayName']),
            subtitle: Text('Phones: ${contact['phones'].join(', ')}'),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isInList) {
                    maListeDeContacts.removeWhere(
                        (c) => c['displayName'] == contact['displayName']);
                  } else {
                    maListeDeContacts.add({
                      'displayName': contact['displayName'],
                      'phones': contact['phones'].join(', '),
                    });
                  }
                });
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
          print(maListeDeContacts); // Affiche les contacts sélectionnés
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
      });
    }

    String contactsJson = jsonEncode(contactsList);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contactsJson: contactsJson),
      ),
    );
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}
