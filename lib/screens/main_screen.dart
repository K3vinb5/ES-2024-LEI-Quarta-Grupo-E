import 'package:flutter/material.dart';

///Classe's widget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  String get title {
    return "";
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

///Classe's State
class _MainScreenState extends State<MainScreen> {
  ///UI of class
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TODO Buttons (Do Styled Button Widget on another file!!)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO Table Widget (Do Table Widget on another file!!)
          ],
        ),
      ],
    );
  }
}
