import 'package:calendario_iscte/widgets/style/styled_button.dart';
import 'package:flutter/material.dart';

class SaveFileDialog extends StatelessWidget {
  const SaveFileDialog({super.key, required this.title, required this.onTap1, required this.onTap2});

  final void Function() onTap1;
  final void Function() onTap2;
  final String title;

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
