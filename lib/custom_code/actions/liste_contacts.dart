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

Future<String?> listeContacts() async {
  /// MODIFY CODE ONLY BELOW THIS LINE
  List<Map<String, dynamic>> contactsList = [];

  try {
    // Demande de permission pour accéder aux contacts
    await Permission.contacts.request();

    // Récupération des contacts
    List<Contact> contacts = await FastContacts.getAllContacts();

    // Ajout des détails des contacts dans la liste JSON
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
  } catch (e) {
    return 'Failed to get contacts: ${e.toString()}';
  }

  // Retourne les contacts au format JSON
  return jsonEncode(contactsList);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
