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

Widget ContactsPage({required String contactsJson}) {
  // Convertir le JSON en liste
  List<dynamic> contactsList = jsonDecode(contactsJson);
  return Scaffold(
    appBar: AppBar(
      title: Text('Liste des Contacts'),
    ),
    body: ListView.builder(
      itemCount: contactsList.length,
      itemBuilder: (context, index) {
        var contact = contactsList[index];
        return ListTile(
          title: Text(contact['displayName']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phones: ${contact['phones'].join(', ')}'),
              Text('Emails: ${contact['emails'].join(', ')}'),
              Text('Organization: ${contact['organization']['company']}'),
            ],
          ),
        );
      },
    ),
  );
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
        'nameParts': {
          'prefix': contact.structuredName?.namePrefix ?? '',
          'givenName': contact.structuredName?.givenName ?? '',
          'middleName': contact.structuredName?.middleName ?? '',
          'familyName': contact.structuredName?.familyName ?? '',
          'suffix': contact.structuredName?.nameSuffix ?? '',
        },
        'organization': {
          'company': contact.organization?.company ?? '',
          'department': contact.organization?.department ?? '',
          'jobDescription': contact.organization?.jobDescription ?? '',
        }
      });
    }
    // Convertir la liste des contacts en JSON
    String contactsJson = jsonEncode(contactsList);
    // Naviguer vers la page cible en passant le JSON
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(
            contactsJson:
                contactsJson), // Assurez-vous que ce widget est bien défini
      ),
    );
  } catch (e) {
    // Gérer l'erreur ici
    print('Failed to get contacts: ${e.toString()}');
  }
}
