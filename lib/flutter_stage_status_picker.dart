library flutter_stage_status_picker;

import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class StateStatusPicker extends StatefulWidget {
  final List<StatusPickerOption> options;
  final Function(List<StatusPickerOption>) onChanged; 
  const StateStatusPicker({
    super.key,
    required this.options,
    required this.onChanged,
  });

  @override
  State<StateStatusPicker> createState() => _StateStatusPickerState();
}

class _StateStatusPickerState extends State<StateStatusPicker> {
  late List<StatusPickerOption> innerOptions;

  @override
  void initState() {
    innerOptions = widget.options;
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: const Text("Seleccione"),
      itemBuilder: (context) => List.generate(innerOptions.length, (index) {
        var item = innerOptions[index];
        return PopupMenuItem<int>(
          value: index,
          child: StatefulBuilder(
            builder: (context, setInnerState) {
              return Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(child: Text(item.label)),
                  Switch(
                    value: item.selected,
                    onChanged: (bool value) {
                      setInnerState(() {
                        item = StatusPickerOption(
                          label: item.label,
                          color: item.color,
                          selected: value,
                        );
                        innerOptions[index] = item;
                      });
                      setState(() {
                        innerOptions = List.from(innerOptions);
                      });
                      widget.onChanged(innerOptions);
                    },
                  ),
                ],
              );
            }
          ),
        );
      }),
    );
  }
}
