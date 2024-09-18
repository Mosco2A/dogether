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

Future<dynamic> listContactFromPhoneBook() async {
  // create action will list contacts from phone book
  List<Contact> contacts =
      await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
  return contacts;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
