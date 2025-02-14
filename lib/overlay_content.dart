import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class OverlayContent extends StatelessWidget {
  final Offset offset;
  final Size size;
  final Function() onClose;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function() onSelectAll;
  final Function(StatusPickerOption) onOptionSelected;
  final List<StatusPickerOption> options;

  const OverlayContent({
    super.key,
    required this.offset,
    required this.size,
    required this.onClose,
    required this.controller,
    this.onChanged,
    required this.onSelectAll,
    required this.onOptionSelected,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final filteredOptions = options.where((option) => option.label.toLowerCase().contains(controller.text.toLowerCase()));
    return Stack(
      children: [
        // Detección de clic fuera del dropdown
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Caja de texto para filtrar opciones
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                            hintText: "Search status...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: onChanged
                        ),
                      ),
                      // Botón adicional dentro del Dropdown
                      TextButton(
                        onPressed: () {
                          print("Extra Button Clicked");
                        },
                        child: Text("Select all", style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14
                        )),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Lista de opciones
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = filteredOptions.elementAt(index);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: option.color,
                                        shape: BoxShape.circle
                                      ),
                                      margin: const EdgeInsets.only(
                                        right: 8
                                      ),
                                    ),
                                    Text(option.label, style: const TextStyle(
                                      fontWeight: FontWeight.w500
                                    )),
                                  ],
                                ),
                                Switch(
                                  value: option.selected, 
                                  onChanged: (newValue){
                            
                                  }
                                ),
                              ],
                            ),
                          );
                        }
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}