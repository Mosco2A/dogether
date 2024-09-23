// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class PickDateTime extends StatelessWidget {
  final double? width; // Optionnel : largeur
  final double? height; // Optionnel : hauteur

  const PickDateTime({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? dateTime = await showOmniDateTimePicker(
          context: context,
          type: OmniDateTimePickerType.dateAndTime,
        );

        if (dateTime != null) {
          debugPrint('DateTime sélectionnée : $dateTime');
        }
      },
      child: Container(
        width: width, // Utilisation du paramètre width
        height: height, // Utilisation du paramètre height
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: const Text('Sélectionner une Date et Heure',
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
