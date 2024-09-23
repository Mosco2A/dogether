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
  const PickDateTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
      children: [
        ElevatedButton(
          onPressed: () async {
            final DateTime? dateTime = await showOmniDateTimePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000), // Date minimum
              lastDate: DateTime(2100), // Date maximum
            );

            if (dateTime != null) {
              // Utilise la date sélectionnée ici
              debugPrint('DateTime sélectionnée : $dateTime');
            }
          },
          child: const Text('Sélectionner une Date et Heure'),
        ),
        ElevatedButton(
          onPressed: () async {
            final List<DateTime>? dateTimeRange =
                await showOmniDateTimeRangePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000), // Date minimum
              lastDate: DateTime(2100), // Date maximum
            );

            if (dateTimeRange != null && dateTimeRange.isNotEmpty) {
              // Utilise la plage de dates ici
              debugPrint('Plage de dates sélectionnée : $dateTimeRange');
            }
          },
          child: const Text('Sélectionner une Plage de Dates'),
        ),
      ],
    );
  }
}
