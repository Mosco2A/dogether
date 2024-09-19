import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? decode() {
  // Vérifie si contactsJson est non nul et non vide
  var contactsJson;
  if (contactsJson != null && contactsJson!.isNotEmpty) {
    try {
      // Décoder la chaîne JSON
      List<dynamic> decodedJson = jsonDecode(contactsJson!);

      // Convertir la liste dynamique en liste de maps
      List<Map<String, dynamic>> contactList =
          List<Map<String, dynamic>>.from(decodedJson);

      // Exemple : Manipuler et afficher le premier contact
      if (contactList.isNotEmpty) {
        Map<String, dynamic> firstContact = contactList[0];
        String name = firstContact['name'];
        List<dynamic> phones = firstContact['phones'];
        List<dynamic> emails = firstContact['emails'];

        // Retourner une chaîne formatée pour le premier contact
        return 'Nom: $name, Téléphones: ${phones.join(", ")}, Emails: ${emails.join(", ")}';
      } else {
        return 'Aucun contact trouvé';
      }
    } catch (e) {
      print('Erreur lors du décodage du JSON : $e');
      return null;
    }
  }

  return 'Données JSON vides';
}
