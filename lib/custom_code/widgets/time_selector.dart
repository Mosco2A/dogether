// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class TimeSelector extends StatefulWidget {
  final double width;
  final double height;

  TimeSelector({this.width = 300.0, this.height = 100.0});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  double _selectedHours = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Slider(
            value: _selectedHours,
            min: 3,
            max: 96,
            divisions: 93,
            label: "${_selectedHours.toStringAsFixed(0)} heures",
            onChanged: (value) {
              setState(() {
                _selectedHours = value < 24 ? value : value.round().toDouble();
              });
            },
          ),
          Text("Heures sélectionnées: ${_selectedHours.toStringAsFixed(0)}"),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
