import 'package:flutter/material.dart';
import 'widgets.dart';

class MyDataColumnLabel extends StatefulWidget {
  const MyDataColumnLabel({
    super.key,
    required this.text,
    required this.onChanged,
    required this.onTap,
    required this.active,
    required this.ascending,
    required this.searchLogic,
    required this.hideColumn,
  });

  final String text;
  final void Function(String) onChanged;
  final void Function() onTap;
  final bool ascending;
  final bool active;
  final bool searchLogic;
  final void Function() hideColumn;

  @override
  State<MyDataColumnLabel> createState() => _MyDataColumnLabelState();
}

class _MyDataColumnLabelState extends State<MyDataColumnLabel> {
  TextEditingController controller = TextEditingController();
  late TextField textField;

  @override
  void initState() {
    super.initState();
    textField = TextField(
      onChanged: widget.onChanged,
      controller: controller,

    );
  }

  @override
  void didUpdateWidget(covariant MyDataColumnLabel oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchLogic != widget.searchLogic) {
      if (controller.text != "") {
        controller.text = "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: widget.hideColumn,
                    icon: const Icon(Icons.cancel_outlined),
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: InkWell(
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
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
              child: /*TextField(
                onChanged: widget.onChanged,
                controller: controller,
              ),*/
                  textField,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
