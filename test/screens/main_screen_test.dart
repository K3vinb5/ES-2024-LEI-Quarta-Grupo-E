import 'package:flutter_test/flutter_test.dart';
import 'package:calendario_iscte/screens/main_screen.dart';

void main() {
  group('Main Screen Testing Suit', () {

    test('Initialize Main Screen Widget and Title', () {
      const mainScreen = MainScreen();

      expect(mainScreen, isNotNull);
      expect(mainScreen.title, '');
    });

    test('Test Main Screen title', () {
      const mainScreen = MainScreen();


    });

  });
}