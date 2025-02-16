import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

class OverlayContent extends StatefulWidget {
  final Offset offset;
  final Size size;
  final Function() onClose;
  final TextEditingController controller;
  final Function() onSelectAll;
  final Function(List<StatusPickerOption>) onChanged;
  final List<StatusPickerOption> options;
  final String? placeholder;

  const OverlayContent({
    super.key,
    required this.offset,
    required this.size,
    required this.onClose,
    required this.controller,
    required this.onSelectAll,
    required this.onChanged,
    required this.options,
    this.placeholder
  });

  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent> {
  late List<StatusPickerOption> innerOptions;

  @override
  void initState() {
    innerOptions = widget.options;
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    final filteredOptions = innerOptions.where((option) => option.label.toLowerCase().contains(widget.controller.text.toLowerCase()));
    return Stack(
      children: [
        // Detección de clic fuera del dropdown
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          left: widget.offset.dx,
          top: widget.offset.dy + widget.size.height + 5,
          width: widget.size.width,
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
                          controller: widget.controller,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                            hintText: widget.placeholder,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // onChanged: widget.onChanged
                        ),
                      ),
                      // Botón adicional dentro del Dropdown
                      TextButton(
                        onPressed: () {
                          setState(() {
                            innerOptions = innerOptions.map((e) => e.copyWith(
                              selected: true
                            )).toList();
                          });
                          widget.onChanged(innerOptions);
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
                                    setState(() {
                                      innerOptions = innerOptions.map((e) => e.id == option.id ? option.copyWith(
                                        selected: newValue
                                      ) : e).toList();
                                    });
                                    widget.onChanged(innerOptions);
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