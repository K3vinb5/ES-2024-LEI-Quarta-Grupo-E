import 'package:flutter/material.dart';

/// A styled text field widget for entering text.
class StyledTextField extends StatelessWidget {

  /// Constructs a [StyledTextField] widget.
  const StyledTextField(
      {super.key,
      required this.width,
      required this.controller,
      this.onChanged,
      required this.color,
      required this.hintColor,
      this.label,
      required this.hint});

  /// The width of the text field.
  final double width;

  /// The controller for the text field.
  final TextEditingController controller;

  /// A callback function that is called when the text field's value changes.
  final void Function(String)? onChanged;

  /// The color of the text field borders, cursor, and text.
  final Color color;

  /// The color of the hint text.
  final Color hintColor;

  /// The label text to be displayed above the text field.
  final String? label;

  /// The hint text to be displayed when the text field is empty.
  final String hint;

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: color),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: color),
          ),
          hintText: hint,
          labelText: label,
          hintStyle: TextStyle(
            color: hintColor,
          ),
        ),
        cursorColor: color,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
