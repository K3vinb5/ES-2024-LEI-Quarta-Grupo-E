import 'dart:io';

import 'package:calendario_iscte/models/class_model.dart';
import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calendario_iscte/screens/screens.dart';
import 'package:calendario_iscte/screens/classes_screen.dart';

void main() {
  group('Main Screen Testing Suit', () {

    test('Initialize Main Screen Widget and Title', () {
      const classesScreen = ClassesScreen();

      expect(classesScreen, isNotNull);
    });

    test('Test Main Screen title', () {
      const classesScreen = ClassesScreen();

    });

  });



  
}