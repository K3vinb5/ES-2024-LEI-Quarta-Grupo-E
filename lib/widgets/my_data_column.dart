import 'package:flutter/material.dart';
import 'widgets.dart';

class MyDataColumnLabel extends StatefulWidget {
  MyDataColumnLabel(
      {super.key, required this.text, required this.onChanged, required this.onTap, required this.active, required this.ascending});

  final String text;
  final void Function(String) onChanged;
  final void Function() onTap;
  final bool ascending;
  final bool active;

  @override
  State<MyDataColumnLabel> createState() => _MyDataColumnLabelState();
}

class _MyDataColumnLabelState extends State<MyDataColumnLabel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.text,
                ),
                SortIcon(ascending: widget.ascending, active: widget.active),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
