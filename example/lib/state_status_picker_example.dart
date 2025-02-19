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
      label: "Math", 
      color: Colors.red,
      selected: true
    ),
    StatusPickerOption(
      id: "2",
      label: "Chemistry", 
      color: Colors.blue,
      selected: false
    ),
    StatusPickerOption(
      id: "3",
      label: "Physics", 
      color: Colors.yellow,
      selected: false
    ),
    StatusPickerOption(
      id: "4",
      label: "Aritmetics", 
      color: Colors.green,
      selected: false
    ),
    StatusPickerOption(
      id: "5",
      label: "Biology", 
      color: Colors.purple,
      selected: false
    ),
    StatusPickerOption(
      id: "6",
      label: "History", 
      color: Colors.orange,
      selected: false
    ),
  ]; 

  @override
  Widget build(BuildContext context) {
    return StateStatusPicker(
      options: list,
      width: 300,
      overlayHeight: 150,
      onChanged: (List<StatusPickerOption> options) {
        setState(() {
          list = options;
        });
      },
    );
  }
}