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
import 'dart:convert'; // Import for JSON encoding

Future<dynamic> listContactFromPhoneBook() async {
  // Get the list of contacts from the phone book
  List<Contact> contacts = await FlutterContacts.getContacts(
    withProperties: true,
    withPhoto: false,
  );

  // Map the contacts to a JSON-friendly format
  List<Map<String, dynamic>> contactList = contacts.map((contact) {
    return {
      'name': contact.displayName,
      'phoneNumbers': contact.phones.map((phone) => phone.number).toList(),
      'emails': contact.emails.map((email) => email.address).toList(),
    };
  }).toList();

  // Return the contacts as a JSON string
  return jsonEncode(contactList);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
