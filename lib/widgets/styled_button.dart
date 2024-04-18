import 'package:flutter/material.dart';

/// A custom styled button widget.
///
/// This widget represents a button with custom styling. It consists of a text label
/// and an optional icon. The button's appearance is defined by the provided text,
/// icon, and onPressed callback.
class StyledButton extends StatelessWidget {

  /// Creates a styled button.
  ///
  /// The [onPressed], [text], and [icon] parameters are required.
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon
  });

  /// The callback function to be called when the button is pressed.
  final void Function() onPressed;

  /// The text to display on the button.
  final String text;

  /// The icon to display on the button (optional).
  final IconData icon;

  /// Builds the widget tree for this button.
  ///
  /// Returns:
  /// A widget representing the styled button
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(
              width: 20,
              height: 45,
            ),
            Icon(
              icon,
              color: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}
