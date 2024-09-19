// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports nécessaires
import 'dart:convert'; // Pour jsonEncode
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

// Ton programme : listContactFromPhoneBook
Future<String?> listContactFromPhoneBook(BuildContext context) async {
  try {
    // Étape 1 : Récupérer les contacts avec leurs propriétés
    List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: false);

    // Étape 2 : Convertir les contacts en une liste de Map
    List<Map<String, dynamic>> contactMaps = contacts.map((contact) {
      return {
        'name': contact.displayName,
        'phones': contact.phones.map((phone) => phone.number).toList(),
        'emails': contact.emails.map((email) => email.address).toList(),
      };
    }).toList();

    // Étape 3 : Convertir la liste de contacts en JSON
    String jsonContacts = jsonEncode(contactMaps);

    // Étape 4 : Naviguer vers la page de destination avec les données encodées en JSON
    context.go('/creer', extra: jsonContacts);

    // Retourner la chaîne JSON
    return jsonContacts;
  } catch (e) {
    // Gestion d'erreur si quelque chose ne va pas
    print('Erreur lors de la récupération des contacts : $e');
    return null; // Retourner null en cas d'erreur
  }
}
