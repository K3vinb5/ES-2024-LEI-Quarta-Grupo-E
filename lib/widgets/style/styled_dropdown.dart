import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

/// A styled drop-down widget that allows selecting an item from a list of options.
class StyledDropDown extends StatefulWidget {

  /// Constructs a [StyledDropDown] widget.
  const StyledDropDown({
    super.key,
    required this.items,
    required this.horizontalPadding,
    required this.onTap,
    required this.width,
    this.hint,
    this.changeValue,
  });

  /// The list of items to be displayed in the drop-down.
  final List<Widget> items;

  /// The horizontal padding of the drop-down container.
  final double horizontalPadding;

  /// A callback function that is called when an item is tapped.
  final void Function(int) onTap;

  /// The width of the drop-down container.
  final double width;

  /// An optional hint to be displayed when no item is selected.
  final String? hint;

  /// A flag indicating whether to change the value on item selection.
  final bool? changeValue;

  @override
  State<StyledDropDown> createState() => _StyledDropDownState();
}

/// The state class for the [StyledDropDown] widget.
class _StyledDropDownState extends State<StyledDropDown> {
  int value = 0;

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.indigo),
      ),
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: SizedBox(
        width: widget.width,
        height: 45,
        child: DropdownButton(
          hint: widget.hint != null ? Text(widget.hint!) : null,
          padding: const EdgeInsets.only(left: 10),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          dropdownColor: Colors.white,
          focusColor: Colors.transparent,
          underline: const SizedBox(),
          value: value,
          items: [
            ...widget.items.mapIndexed(
              (index, childWidget) {
                return DropdownMenuItem(
                  onTap: () {
                    if (widget.changeValue != null && widget.changeValue!) {
                      setState(() {
                        value = index;
                      });
                      widget.onTap(index);
                    }
                  },
                  value: index,
                  child: childWidget,
                );
              },
            ),
          ],
          onChanged: (index) {
            widget.onTap(index!);
          },
        ),
      ),
    );
  }
}
