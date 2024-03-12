import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  const DrawerTitle({super.key});

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
