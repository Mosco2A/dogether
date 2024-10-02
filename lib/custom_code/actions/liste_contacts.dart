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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

/// Action personnalisée pour lister les contacts, gérer les permissions,
/// et sauvegarder les contacts dans Firestore.
///
/// [context] : BuildContext nécessaire pour afficher des SnackBars.
Future<void> listeContacts(BuildContext context) async {
  // Initialiser les instances Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Demander la permission d'accéder aux contacts
  PermissionStatus permissionStatus = await Permission.contacts.request();

  if (!permissionStatus.isGranted) {
    // Gérer le refus de permission
    print('Permission d\'accéder aux contacts refusée');

    // Si la permission est définitivement refusée, ouvrir les paramètres de l'application
    if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    }

    // Afficher un message à l'utilisateur
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Permission d\'accéder aux contacts refusée'),
    ));
    return;
  }

  try {
    // Récupérer les contacts
    List<Contact> contacts = await FastContacts.getAllContacts();

    if (contacts.isEmpty) {
      print('Aucun contact trouvé.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Aucun contact trouvé.'),
      ));
      return;
    }

    // Transformer les contacts en une liste de maps
    List<Map<String, dynamic>> contactsList = contacts.map((contact) {
      return {
        'displayName': contact.displayName ?? 'No Name',
        'phones': contact.phones.map((e) => e.number).toList(),
        'emails': contact.emails.map((e) => e.address).toList(),
      };
    }).toList();

    // Convertir la liste des contacts en JSON
    String contactsJson = jsonEncode(contactsList);

    // Sauvegarder les contacts dans Firestore sous le document de l'utilisateur
    String? userId = auth.currentUser?.uid;
    if (userId != null) {
      await firestore.collection('users').doc(userId).set({
        'contacts': contactsJson,
      }, SetOptions(merge: true));

      print('Contacts sauvegardés avec succès.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Contacts sauvegardés avec succès.'),
      ));
    } else {
      print('Utilisateur non authentifié.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Utilisateur non authentifié.'),
      ));
    }
  } catch (e) {
    print('Échec de la récupération des contacts: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erreur lors de la récupération des contacts.'),
    ));
  }
}
