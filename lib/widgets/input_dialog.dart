import 'package:flutter/material.dart';

/// A dialog widget for inputting a string.
class InputDialog extends StatelessWidget {

  /// Constructs an [InputDialog] with the specified parameters.
  ///
  /// The [text] parameter is the text to display on the input dialog.
  /// The [onInputSubmitted] parameter is a callback function that handles the input string.
  InputDialog({
    super.key,
    required this.text,
    required this.onInputSubmitted
  });

  /// A controller for the input text field.
  final TextEditingController stringController = TextEditingController();

  /// Callback function to handle the input String
  final Function(String)? onInputSubmitted;

  /// The text to display on the input dialog.
  final String text;

  /// Builds the widget tree for this input dialog box.
  ///
  /// Returns:
  /// A Widget representing the input dialog
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: TextField(
        controller: stringController,
        decoration: const InputDecoration(
            labelText: 'URL',
            hintText: 'Introduza uma URL válida',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            String string = stringController.text;

            if(onInputSubmitted != null) {
              onInputSubmitted!(string);
            }

            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Submeter'),
        ),
      ],
    );
  }

}