import 'package:flutter/material.dart';

class StatusPickerOption {
  final String id;
  final String label;
  final Color color;
  final bool selected;

  StatusPickerOption({
    required this.id,
    required this.label,
    required this.color,
    required this.selected,
  });

  StatusPickerOption copyWith({
    String? id,
    String? label,
    Color? color,
    bool? selected,
  }) {
    return StatusPickerOption(
      id: id ?? this.id,
      label: label ?? this.label,
      color: color ?? this.color,
      selected: selected ?? this.selected,
    );
  }
}