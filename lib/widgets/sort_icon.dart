import 'package:flutter/material.dart';

class SortIcon extends StatelessWidget {
  final bool ascending;
  final bool active;

  const SortIcon({super.key, required this.ascending, required this.active});

  @override
  Widget build(BuildContext context) {
    return Icon(
      ascending ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
      size: 28,
      color: active ? Colors.black : Colors.black12,
    );
  }
}