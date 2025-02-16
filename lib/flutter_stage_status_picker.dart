library flutter_stage_status_picker;

import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/overlay_content.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class StateStatusPicker extends StatefulWidget {
  final double width;
  final List<StatusPickerOption> options;
  final Function(List<StatusPickerOption>) onChanged;
  final String placeholderBox;
  final String placeholderOverlay;

  const StateStatusPicker({
    super.key,
    required this.width,
    required this.options,
    required this.onChanged,
    this.placeholderBox = "Select",
    this.placeholderOverlay = "Search status...",
  });

  @override
  State<StateStatusPicker> createState() => _StateStatusPickerState();
}

class _StateStatusPickerState extends State<StateStatusPicker> {

  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayContent(
        offset: offset, 
        size: size, 
        onClose: _closeDropdown, 
        controller: _searchController, 
        onSelectAll: (){}, 
        onChanged: widget.onChanged,
        options: widget.options,
        placeholder: widget.placeholderOverlay,
      )
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

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
          child: GestureDetector(
            key: _buttonKey,
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    selectedOptions.isEmpty ? Text(widget.placeholderBox, style: TextStyle(
                      color: Colors.grey[500]!
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
                    Text(selectedOptions.map((e) => e.label).join(", "), style: const TextStyle(
                      fontWeight: FontWeight.w500
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
