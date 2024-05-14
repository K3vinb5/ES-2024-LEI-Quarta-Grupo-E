import 'package:calendario_iscte/widgets/style/styled_button.dart';
import 'package:flutter/material.dart';

/// A dialog widget for saving files.
///
/// This widget is a dialog that allows users to save files. It extends [StatelessWidget]
/// as it does not need to manage any mutable state.
class SaveFileDialog extends StatelessWidget {

  /// Constructs a [SaveFileDialog] widget.
  ///
  /// The [title] parameter is required and specifies the title of the dialog.
  /// The [onTap1] and [onTap2] parameters are required and specify the callback functions
  /// for the two possible actions the user can take in the dialog.
  const SaveFileDialog({super.key, required this.title, required this.onTap1, required this.onTap2});

  /// Callback function for the first action the user can take in the dialog.
  final void Function() onTap1;

  /// Callback function for the second action the user can take in the dialog.
  final void Function() onTap2;

  /// The title of the dialog.
  final String title;

  /// Build this Widget's UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 197,223,243),
      title: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.33,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Por favor selecione um dos formatos disponiveis para guardar a tabela."),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledButton(onPressed: onTap1, text: "Guardar CSV", icon: Icons.save_alt, width: MediaQuery.of(context).size.width * 0.15,),
                const SizedBox(width: 20,),
                StyledButton(onPressed: onTap2, text: "Guardar JSON", icon: Icons.save_alt, width: MediaQuery.of(context).size.width * 0.15,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
