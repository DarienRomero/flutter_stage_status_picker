import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/custom_switch.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

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
  late List<StatusPickerOption> innerOptions;

  @override
  void initState() {
    innerOptions = widget.options;
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    final filteredOptions = innerOptions.where((option) => removeDiacritics(option.label).toLowerCase().startsWith(removeDiacritics(widget.controller.text).toLowerCase()));
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
                            hintText: widget.placeholder,
                            hintStyle: TextStyle(
                              color: widget.hintTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            innerOptions = innerOptions.map((e) => e.copyWith(
                              selected: true
                            )).toList();
                          });
                          widget.onChanged(innerOptions);
                        },
                        child: Text(widget.selectAllText, style: TextStyle(
                          color: widget.selectAllTextColor,
                          fontSize: 14
                        )),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Lista de opciones
                  SizedBox(
                    height: widget.overlayHeight,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
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
                                  SizedBox(
                                    width: widget.size.width - 120,
                                    child: Text(option.label, style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: widget.optionTextColor
                                    ), 
                                    maxLines: 1, 
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  ),
                                ],
                              ),
                              CustomSwitch(
                                value: option.selected,
                                onChanged: (newValue){
                                  switchOnChanged(newValue, option);
                                }
                              )
                            ],
                          ),
                        );
                      }
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
  void switchOnChanged(bool newValue, StatusPickerOption option){
    setState(() {
      innerOptions = innerOptions.map((e) => e.id == option.id ? option.copyWith(
        selected: newValue
      ) : e).toList();
    });
    widget.onChanged(innerOptions);
  }
}