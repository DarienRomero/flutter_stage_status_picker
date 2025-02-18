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
      label: "Perro", 
      color: Colors.red,
      selected: true
    ),
    StatusPickerOption(
      id: "2",
      label: "Gato", 
      color: Colors.blue,
      selected: false
    ),
    StatusPickerOption(
      id: "3",
      label: "Conejo", 
      color: Colors.yellow,
      selected: false
    ),
    StatusPickerOption(
      id: "4",
      label: "Tortuga", 
      color: Colors.green,
      selected: false
    ),
    StatusPickerOption(
      id: "5",
      label: "Pez", 
      color: Colors.orange,
      selected: false
    ),
    StatusPickerOption(
      id: "6",
      label: "Hámster", 
      color: Colors.purple,
      selected: false
    ),
    StatusPickerOption(
      id: "7",
      label: "Loro", 
      color: Colors.pink,
      selected: false
    ),
    StatusPickerOption(
      id: "8",
      label: "Erizo", 
      color: Colors.brown,
      selected: false
    ),
  ]; 

  @override
  Widget build(BuildContext context) {
    return StateStatusPicker(
      options: list,
      width: 400,
      overlayHeight: 150,
      onChanged: (List<StatusPickerOption> options) {
        setState(() {
          list = options;
        });
      },
    );
  }
}