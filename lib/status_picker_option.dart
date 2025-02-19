import 'package:flutter/material.dart';

/// A class representing an option in the status picker.
class StatusPickerOption {
  final String id;
  final String label;
  final Color color;
  final bool selected;

  /// Creates a new [StatusPickerOption].
  ///
  /// All parameters are required.
  StatusPickerOption({
    required this.id,
    required this.label,
    required this.color,
    required this.selected,
  });

  /// Creates a copy of this [StatusPickerOption] but with the given fields
  /// replaced with the new values.
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