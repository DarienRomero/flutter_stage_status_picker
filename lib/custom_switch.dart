import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoSwitch(
      value: value, 
      onChanged: onChanged
    ) : Switch(
      value: value, 
      onChanged: onChanged
    );
  }
}