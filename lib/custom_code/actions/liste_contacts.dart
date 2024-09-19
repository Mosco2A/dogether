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
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:fast_contacts/fast_contacts.dart'; // Ajouter l'import pour les contacts
import 'package:permission_handler/permission_handler.dart'; // Ajouter l'import pour la gestion des permissions

Future<String?> listeContacts() async {
  /// MODIFY CODE ONLY BELOW THIS LINE
  List<Contact> contacts = [];
  List<Map<String, dynamic>> contactsList =
      []; // Liste pour stocker les contacts sous forme de JSON
  bool isLoading = false;

  List<ContactField> fields = ContactField.values.toList();

  try {
    // Demande de permission pour accéder aux contacts
    await Permission.contacts.request();

    isLoading = true;
    final sw = Stopwatch()..start();

    // Récupération des contacts
    contacts = await FastContacts.getAllContacts(fields: fields);

    sw.stop();

    // Ajout des détails des contacts dans la liste JSON
    for (var contact in contacts) {
      final phones = contact.phones.map((e) => e.number).toList();
      final emails = contact.emails.map((e) => e.address).toList();
      final name = contact.structuredName;
      final organization = contact.organization;

      Map<String, dynamic> contactJson = {
        'displayName': contact.displayName,
        'phones': phones,
        'emails': emails,
        'nameParts': {
          'prefix': name?.namePrefix ?? '',
          'givenName': name?.givenName ?? '',
          'middleName': name?.middleName ?? '',
          'familyName': name?.familyName ?? '',
          'suffix': name?.nameSuffix ?? '',
        },
        'organization': {
          'company': organization?.company ?? '',
          'department': organization?.department ?? '',
          'jobDescription': organization?.jobDescription ?? '',
        }
      };

      contactsList.add(contactJson);
    }
  } catch (e) {
    return 'Failed to get contacts: ${e.toString()}';
  } finally {
    isLoading = false;
  }

  // Conversion de la liste des contacts en JSON
  return jsonEncode(contactsList);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
