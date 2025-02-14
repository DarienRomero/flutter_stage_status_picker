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
}