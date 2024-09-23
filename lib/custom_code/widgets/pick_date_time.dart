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

class PickDateTime extends StatefulWidget {
  final double? width; // Optionnel : largeur
  final double? height; // Optionnel : hauteur
  final ValueChanged<DateTime?> onDateTimeSelected; // Callback pour le résultat

  const PickDateTime({
    Key? key,
    this.width,
    this.height,
    required this.onDateTimeSelected, // Requis
  }) : super(key: key);

  @override
  _PickDateTimeState createState() => _PickDateTimeState();
}

class _PickDateTimeState extends State<PickDateTime> {
  @override
  void initState() {
    super.initState();
    // Afficher le sélecteur dès que le widget est construit
    _showDateTimePicker();
  }

  Future<void> _showDateTimePicker() async {
    final DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
    );

    // Appeler la fonction callback avec la date sélectionnée
    widget.onDateTimeSelected(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width, // Utilisation du paramètre width
      height: widget.height, // Utilisation du paramètre height
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: const Text('Sélection en cours...', textAlign: TextAlign.center),
      ),
    );
  }
}
