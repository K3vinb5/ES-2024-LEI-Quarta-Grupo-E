import 'package:flutter/material.dart';

/// A widget representing the title for a drawer.
class DrawerTitle extends StatelessWidget {

  /// Constructs a [DrawerTitle] widget.
  const DrawerTitle({super.key});

  /// Builds the widget tree for this drawer title.
  ///
  /// Returns:
  /// A Widget representing the Drawer Title
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 100,
            width: double.infinity,
            color: Colors.indigo,
            child: const Center(
              child: Text(
                "Calendário Iscte",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
