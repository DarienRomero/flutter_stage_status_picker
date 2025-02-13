import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/flutter_stage_status_picker.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class StateStatusPickerExample extends StatefulWidget {
  const StateStatusPickerExample({super.key});

  @override
  State<StateStatusPickerExample> createState() => _StateStatusPickerExampleState();
}

class _StateStatusPickerExampleState extends State<StateStatusPickerExample> {
  final list = [
    StatusPickerOption(
      label: "Option 1", 
      color: Colors.red,
      selected: false
    ),
    StatusPickerOption(
      label: "Option 2", 
      color: Colors.blue,
      selected: false
    ),
    StatusPickerOption(
      label: "Option 3", 
      color: Colors.yellow,
      selected: false
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return StateStatusPicker(
      options: list,
      onChanged: (List<StatusPickerOption> options) {
        
      },
    );
  }
}