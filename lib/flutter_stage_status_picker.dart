library flutter_stage_status_picker;

import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/overlay_content.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

/// A widget for selecting statuses with customizable options.
class StateStatusPicker extends StatefulWidget {
  final double width;
  final List<StatusPickerOption> options;
  final Function(List<StatusPickerOption>) onChanged;
  final String boxPlaceholder;
  final String overlayPlaceholder;
  final Color boxPlaceholderTextColor;
  final Color? boxTextColor;
  final double boxBorderRadius;
  final Color boxBorderColor;
  final Color overlayHintTextColor;
  final Color? overlayOptionTextColor;
  final double overlayHeight;
  final String overlaySelectAllText;
  final Color overlaySelectAllTextColor;

  /// Creates a new [StateStatusPicker].
  ///
  /// The [width], [options], and [onChanged] parameters are required.
  const StateStatusPicker({
    super.key,
    required this.width,
    required this.options,
    required this.onChanged,
    this.boxPlaceholder = "Select",
    this.overlayPlaceholder = "Search status...",
    this.boxPlaceholderTextColor = Colors.grey,
    this.boxTextColor,
    this.boxBorderRadius = 10,
    this.boxBorderColor = const Color(0xFFBDBDBD),
    this.overlayHintTextColor = const Color(0xFFBDBDBD),
    this.overlayOptionTextColor,
    this.overlayHeight = 200,
    this.overlaySelectAllText = "Select all",
    this.overlaySelectAllTextColor = const Color(0xFF9E9E9E),
  }) : 
    assert(width >= 300, 'At least 300px width');

  @override
  State<StateStatusPicker> createState() => _StateStatusPickerState();
}

class _StateStatusPickerState extends State<StateStatusPicker> {

  final GlobalKey buttonKey = GlobalKey(debugLabel: "button_key");
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();

  /// Toggles the dropdown menu.
  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  /// Opens the dropdown menu.
  void _openDropdown() {
    RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayContent(
        offset: offset, 
        size: size, 
        onClose: _closeDropdown, 
        controller: _searchController, 
        onChanged: widget.onChanged,
        options: widget.options,
        placeholder: widget.overlayPlaceholder,
        hintTextColor: widget.overlayHintTextColor,
        optionTextColor: widget.overlayOptionTextColor,
        overlayHeight: widget.overlayHeight,
        selectAllText: widget.overlaySelectAllText,
        selectAllTextColor: widget.overlaySelectAllTextColor,
      )
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  /// Closes the dropdown menu.
  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedOptions = widget.options.where((option) => option.selected).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width,
          child: InkWell(
            key: buttonKey,
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(widget.boxBorderRadius),
                border: Border.all(color: widget.boxBorderColor),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    selectedOptions.isEmpty ? Text(widget.boxPlaceholder, style: TextStyle(
                      color: widget.boxPlaceholderTextColor
                    )) :
                    Container(
                      width: 8 * selectedOptions.length + 2,
                      margin: const EdgeInsets.only(
                        right: 8
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: selectedOptions.asMap().entries.map((e) {
                          return (e.key == 0) ? 
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: e.value.color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white
                                )
                              ),
                            ) : Positioned(
                              left: e.key * 8,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: e.value.color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white
                                  )
                                ),
                              ),
                            );
                          }
                        ).toList()
                      ),
                    ),
                    Text(selectedOptions.map((e) => e.label).join(", "), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: widget.boxTextColor
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
