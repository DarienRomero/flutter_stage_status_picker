library flutter_stage_status_picker;

import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/overlay_content.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class StateStatusPicker extends StatefulWidget {
  final double width;
  final List<StatusPickerOption> options;
  final Function(List<StatusPickerOption>) onChanged; 

  const StateStatusPicker({
    super.key,
    required this.width,
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
        onOptionSelected: (option){

        }, 
        options: innerOptions
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8 * innerOptions.length + 2,
                    margin: const EdgeInsets.only(
                      right: 8
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: innerOptions.asMap().entries.map((e) {
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
                  Text(innerOptions.map((e) => e.label).join(", "), style: const TextStyle(
                    fontWeight: FontWeight.w500
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
/* _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Detección de clic fuera del dropdown
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Caja de texto para filtrar opciones
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) => setState(() {}), // Refresca la lista al escribir
                        ),
                      ),
                      // Botón adicional dentro del Dropdown
                      TextButton(
                        onPressed: () {
                          print("Extra Button Clicked");
                        },
                        child: const Text("Extra Button"),
                      ),
                    ],
                  ),
                  // Lista de opciones
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: SingleChildScrollView(
                      child: Column(
                        children: _options
                            .where((option) => option
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase()))
                            .map((option) => ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    setState(() {
                                      _selectedOption = option;
                                    });
                                    _closeDropdown();
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ); */
