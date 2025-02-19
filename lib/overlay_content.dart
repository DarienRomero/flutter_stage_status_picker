import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/custom_switch.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

/// A widget that displays the overlay content for the status picker.
class OverlayContent extends StatefulWidget {
  final Offset offset;
  final Size size;
  final Function() onClose;
  final TextEditingController controller;
  final Function(List<StatusPickerOption>) onChanged;
  final List<StatusPickerOption> options;
  final String? placeholder;
  final Color hintTextColor;
  final Color selectAllTextColor;
  final Color? optionTextColor;
  final double overlayHeight;
  final String selectAllText;

  /// Creates a new [OverlayContent].
  ///
  /// The [offset], [size], [onClose], [controller], [onChanged], [options],
  /// [hintTextColor], [selectAllTextColor], [overlayHeight], and [selectAllText]
  /// parameters are required.
  const OverlayContent({
    super.key,
    required this.offset,
    required this.size,
    required this.onClose,
    required this.controller,
    required this.onChanged,
    required this.options,
    this.placeholder,
    required this.hintTextColor,
    required this.selectAllTextColor,
    required this.optionTextColor,
    required this.overlayHeight,
    required this.selectAllText
  });

  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent> {
  late List<StatusPickerOption> filteredOptions;

  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
    widget.controller.addListener(_filterOptions);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_filterOptions);
    super.dispose();
  }

  void _filterOptions() {
    setState(() {
      filteredOptions = widget.options.where((option) {
        final query = removeDiacritics(widget.controller.text.toLowerCase());
        final label = removeDiacritics(option.label.toLowerCase());
        return label.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.offset.dx,
      top: widget.offset.dy + widget.size.height,
      child: Material(
        elevation: 4.0,
        child: SizedBox(
          width: widget.size.width,
          height: widget.overlayHeight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(color: widget.hintTextColor),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        widget.selectAllText,
                        style: TextStyle(color: widget.selectAllTextColor),
                      ),
                      onTap: () {
                        setState(() {
                          final allSelected = filteredOptions.every((option) => option.selected);
                          for (var option in filteredOptions) {
                            option = option.copyWith(selected: !allSelected);
                          }
                        });
                        widget.onChanged(filteredOptions);
                      },
                    ),
                    ...filteredOptions.map((option) {
                      return ListTile(
                        leading: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: option.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Text(
                          option.label,
                          style: TextStyle(color: widget.optionTextColor),
                        ),
                        trailing: CustomSwitch(
                          value: option.selected,
                          onChanged: (value) {
                            setState(() {
                              option = option.copyWith(selected: value);
                            });
                            widget.onChanged(filteredOptions);
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}