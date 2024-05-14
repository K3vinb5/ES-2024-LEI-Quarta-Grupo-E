import 'package:flutter/material.dart';

/// A styled text field widget for entering text.
class StyledTextField extends StatelessWidget {

  /// Constructs a [StyledTextField] widget.
  const StyledTextField(
      {super.key,
      required this.controller,
      required this.width,
      required this.hint,
      required this.color,
      required this.hintColor,
      this.textColor,
      this.onChanged,
      this.label,
      this.readOnly,
      });

  /// The controller for the text field.
  final TextEditingController controller;

  /// The width of the text field.
  final double width;

  /// The hint text to be displayed when the text field is empty.
  final String hint;

  /// The color of the text field borders and cursor.
  final Color color;

  /// The color of the hint text.
  final Color hintColor;

  /// The color of the text entered in the text field.
  final Color? textColor;

  /// A callback function that is called when the text field's value changes.
  final void Function(String)? onChanged;

  /// The label text to be displayed above the text field.
  final String? label;

  /// A flag indicating whether the text field is read-only.
  final bool? readOnly;

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextField(
        readOnly: readOnly ?? false,
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
          color: textColor ?? color,
        ),
      ),
    );
  }
}
