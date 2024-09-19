// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:convert'; // Pour utiliser jsonEncode

Future<dynamic> listContactFromPhoneBook() async {
  // Récupérer les contacts avec leurs propriétés
  List<Contact> contacts =
      await FlutterContacts.getContacts(withProperties: true, withPhoto: false);

  // Convertir les contacts en une liste de Map
  List<Map<String, dynamic>> contactMaps = contacts.map((contact) {
    return {
      'name': contact.displayName,
      'phones': contact.phones.map((phone) => phone.number).toList(),
      'emails': contact.emails.map((email) => email.address).toList(),
      // Vous pouvez ajouter d'autres champs comme 'photo', 'address', etc.
    };
  }).toList();

  // Convertir la liste en JSON
  String jsonContacts = jsonEncode(contactMaps);

  // Retourner le JSON
  return jsonContacts;
}
