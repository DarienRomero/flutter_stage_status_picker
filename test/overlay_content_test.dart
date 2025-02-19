import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';
import 'package:flutter_stage_status_picker/custom_switch.dart';
import 'package:flutter_stage_status_picker/overlay_content.dart';

void main() {
  group('OverlayContent Widget Tests', () {
    late TextEditingController controller;
    late List<StatusPickerOption> options;

    setUp(() {
      controller = TextEditingController();
      options = [
        StatusPickerOption(id: '1', label: 'Option 1', selected: false, color: Colors.red),
        StatusPickerOption(id: '2', label: 'Option 2', selected: false, color: Colors.blue),
      ];
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OverlayContent(
            offset: Offset.zero,
            size: const Size(200, 300),
            onClose: () {},
            controller: controller,
            onChanged: (List<StatusPickerOption> newOptions) {},
            options: options,
            placeholder: 'Search...',
            hintTextColor: Colors.grey,
            selectAllTextColor: Colors.blue,
            optionTextColor: Colors.black,
            overlayHeight: 100,
            selectAllText: 'Select All',
          ),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Select All'), findsOneWidget);
      expect(find.byType(CustomSwitch), findsNWidgets(2));
    });

    testWidgets('filters options based on text input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OverlayContent(
            offset: Offset.zero,
            size: const Size(200, 300),
            onClose: () {},
            controller: controller,
            onChanged: (List<StatusPickerOption> newOptions) {
              options = newOptions;
            },
            options: options,
            placeholder: 'Search...',
            hintTextColor: Colors.grey,
            selectAllTextColor: Colors.blue,
            optionTextColor: Colors.black,
            overlayHeight: 100,
            selectAllText: 'Select All',
          ),
        ),
      ));

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      
      await tester.enterText(find.byType(TextField), 'Option 1');
      await tester.pump();
      
      expect(find.text('Option 1'), findsNWidgets(2));
      expect(find.text('Option 2'), findsNothing);
    });

    testWidgets('selects all options when Select All is pressed', (WidgetTester tester) async {
      bool selectAllPressed = false;
      
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OverlayContent(
            offset: Offset.zero,
            size: const Size(200, 300),
            onClose: () {},
            controller: controller,
            onChanged: (List<StatusPickerOption> newOptions) {
              selectAllPressed = true;
            },
            options: options,
            placeholder: 'Search...',
            hintTextColor: Colors.grey,
            selectAllTextColor: Colors.blue,
            optionTextColor: Colors.black,
            overlayHeight: 100,
            selectAllText: 'Select All',
          ),
        ),
      ));
      final textFinder = find.text('Select All');

      final buttonFinder = find.ancestor(
        of: textFinder,
        matching: find.byType(TextButton),
      );
      await tester.tap(buttonFinder);
      await tester.pump();
      expect(selectAllPressed, isTrue);
    });
  });
}
