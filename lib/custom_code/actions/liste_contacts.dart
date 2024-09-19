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

String? listeContacts() {
  /// MODIFY CODE ONLY BELOW THIS LINE
  Future<String> getContacts() async {
    List<Contact> contacts = [];
    String result = '';
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
      result =
          'Contacts: ${contacts.length}\nTook: ${sw.elapsedMilliseconds}ms\n\n';

      // Ajout des détails des contacts dans le résultat
      for (var contact in contacts) {
        final phones = contact.phones.map((e) => e.number).join(', ');
        final emails = contact.emails.map((e) => e.address).join(', ');
        final name = contact.structuredName;
        final nameStr = name != null
            ? [
                if (name.namePrefix.isNotEmpty) name.namePrefix,
                if (name.givenName.isNotEmpty) name.givenName,
                if (name.middleName.isNotEmpty) name.middleName,
                if (name.familyName.isNotEmpty) name.familyName,
                if (name.nameSuffix.isNotEmpty) name.nameSuffix,
              ].join(', ')
            : '';
        final organization = contact.organization;
        final organizationStr = organization != null
            ? [
                if (organization.company.isNotEmpty) organization.company,
                if (organization.department.isNotEmpty) organization.department,
                if (organization.jobDescription.isNotEmpty)
                  organization.jobDescription,
              ].join(', ')
            : '';

        result +=
            'Name: ${contact.displayName}\nPhones: $phones\nEmails: $emails\nName Parts: $nameStr\nOrganization: $organizationStr\n\n';
      }
    } on PlatformException catch (e) {
      result = 'Failed to get contacts:\n${e.details}';
    } finally {
      isLoading = false;
    }

    return result;
  }

  return getContacts();

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
