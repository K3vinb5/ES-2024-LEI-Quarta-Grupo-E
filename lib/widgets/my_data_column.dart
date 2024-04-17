import 'package:flutter/material.dart';
import 'widgets.dart';

/// A widget representing the label for a data column.
class MyDataColumnLabel extends StatefulWidget {

  /// Constructs a [MyDataColumnLabel] widget.
  ///
  /// The [text] parameter specifies the text to display on the label.
  /// The [onChanged] parameter is a callback function triggered when the label's value changes.
  /// The [onTap] parameter is a callback function triggered when the label is tapped.
  /// The [ascending] parameter specifies whether the sorting order is ascending.
  /// The [active] parameter specifies whether the label is currently active.
  /// The [searchLogic] parameter specifies whether search logic is enabled.
  /// The [hideColumn] parameter is a callback function triggered when the column is hidden.
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

  /// The text to display on the label.
  final String text;

  /// Callback function triggered when the label's value changes.
  final void Function(String) onChanged;

  /// Callback function triggered when the label is tapped.
  final void Function() onTap;

  /// Specifies whether the sorting order is ascending.
  final bool ascending;

  /// Specifies whether the label is currently active.
  final bool active;

  /// Specifies whether search logic is enabled.
  final bool searchLogic;

  /// Callback function triggered when the column is hidden.
  final void Function() hideColumn;

  @override
  State<MyDataColumnLabel> createState() => _MyDataColumnLabelState();
}

/// The state class for the [MyDataColumnLabel] widget.
///
/// This class manages the state of the [MyDataColumnLabel] widget, including
/// handling text input using a [TextEditingController].
class _MyDataColumnLabelState extends State<MyDataColumnLabel> {

  /// Controller for handling text input.
  TextEditingController controller = TextEditingController();

  /// Text field widget for text input.
  late TextField textField;

  /// Overrides the [initState] method to initialize the state of the widget.
  @override
  void initState() {
    super.initState();
    textField = TextField(
      onChanged: widget.onChanged,
      controller: controller,

    );
  }

  /// Overrides the [didUpdateWidget] method to handle updates to the widget.
  ///
  /// This method checks if the search logic has changed from the previous
  /// widget configuration. If the search logic has changed, it clears the
  /// text field by setting its text to an empty string.
  ///
  /// Parameters:
  /// - [oldWidget]: The previous configuration of the widget.
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

  /// Builds the widget tree for the data column widget
  ///
  /// Returns:
  /// A column widget containing rows for the cancel button, label, and text field.
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
