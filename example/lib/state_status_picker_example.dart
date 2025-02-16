import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/flutter_stage_status_picker.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class StateStatusPickerExample extends StatefulWidget {
  const StateStatusPickerExample({super.key});

  @override
  State<StateStatusPickerExample> createState() => _StateStatusPickerExampleState();
}

class _StateStatusPickerExampleState extends State<StateStatusPickerExample> {
  List<StatusPickerOption> list = [
    StatusPickerOption(
      id: "1",
      label: "Option 1", 
      color: Colors.red,
      selected: true
    ),
    StatusPickerOption(
      id: "2",
      label: "Option 2", 
      color: Colors.blue,
      selected: false
    ),
    StatusPickerOption(
      id: "3",
      label: "Option 3", 
      color: Colors.yellow,
      selected: false
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return StateStatusPicker(
      options: list,
      width: 400,
      onChanged: (List<StatusPickerOption> options) {
        setState(() {
          list = options;
        });
      },
    );
  }
}