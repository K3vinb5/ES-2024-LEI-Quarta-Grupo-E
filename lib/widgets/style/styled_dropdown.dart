import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class StyledDropDown extends StatefulWidget {
  const StyledDropDown({
    super.key,
    required this.items,
    required this.horizontalPadding,
    required this.onTap,
    required this.width,
    this.hint,
    this.changeValue,
  });

  final List<Widget> items;
  final double horizontalPadding;
  final void Function(int) onTap;
  final double width;
  final String? hint;
  final bool? changeValue;

  //final Color borderColor;
  //final Color textColor;
  //final Color backgroundOpenColor;

  @override
  State<StyledDropDown> createState() => _StyledDropDownState();
}

class _StyledDropDownState extends State<StyledDropDown> {
  int value = 0;

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
