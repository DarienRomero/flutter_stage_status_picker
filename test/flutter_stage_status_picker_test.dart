import 'package:flutter/material.dart';
import 'package:flutter_stage_status_picker/flutter_stage_status_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_stage_status_picker/status_picker_option.dart';

void main() {
  group('StateStatusPicker Tests', () {
    testWidgets('Lanza un assert si el ancho es menor a 300', (WidgetTester tester) async {
      expect(
        () => StateStatusPicker(
          width: 250, // Menor a 300, debería fallar
          options: const [],
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );
    });

    testWidgets('Muestra el placeholder si no hay opciones seleccionadas', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StateStatusPicker(
              width: 300,
              options: const [],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('Abre y cierra el dropdown correctamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StateStatusPicker(
              width: 300,
              options: [
                StatusPickerOption(label: 'Option 1', color: Colors.red, selected: false, id: '1'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      //Initially there's no Overlay opened
      expect(find.text("Search status..."), findsNothing);


      final buttonFinder = find.byType(InkWell).first;
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pump();

      //One Overlay opened
      expect(find.text("Search status..."), findsOne);

      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pump();
      
      //Finally there's no Overlay opened
      expect(find.text("Search status..."), findsNothing);
    });

    testWidgets('Muestra opciones seleccionadas correctamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StateStatusPicker(
              width: 300,
              options: [
                StatusPickerOption(label: 'Selected Option', color: Colors.blue, selected: true, id: '1'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Selected Option'), findsOneWidget);
    });

  });
}
