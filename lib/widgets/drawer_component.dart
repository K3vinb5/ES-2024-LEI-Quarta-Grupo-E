import 'package:flutter/material.dart';

/// Represents a drawer item component.
class DrawerComponent extends StatelessWidget {

  /// Constructs a [DrawerComponent] widget.
  ///
  /// The [text] parameter specifies the text to display on the drawer item.
  /// The [onTap] parameter is a callback function triggered when the item is tapped.
  const DrawerComponent({super.key, required this.text, required this.onTap});

  /// The text to display on the drawer item.
  final String text;

  /// Callback function triggered when the item is tapped.
  final void Function() onTap;

  /// Builds the widget tree for the drawer item.
  ///
  /// Returns:
  /// A new DrawerComponent widget
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(10, 0, 0, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
