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

DateTime addMonthToDate() {
  DateTime now = DateTime.now();
  int monthsToAdd = 12; // Exemple d'ajout d'un mois
  DateTime newDate = DateTime(
    now.year,
    now.month + monthsToAdd,
    math.min(now.day, DateTime(now.year, now.month + monthsToAdd + 1, 0).day),
    now.hour, // Ajoute l'heure
    now.minute, // Ajoute les minutes
    now.second, // Ajoute les secondes
  );
  return newDate; // Retourne un DateTime
}
