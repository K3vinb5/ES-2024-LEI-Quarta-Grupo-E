import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
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

  final TextEditingController controller;
  final double width;
  final String hint;
  final Color color;
  final Color hintColor;
  final Color? textColor;
  final void Function(String)? onChanged;
  final String? label;
  final bool? readOnly;

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
