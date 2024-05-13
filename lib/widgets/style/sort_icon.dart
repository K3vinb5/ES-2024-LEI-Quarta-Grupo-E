import 'package:flutter/material.dart';

/// A widget representing a sort icon.
///
/// This widget displays an arrow icon indicating the sorting order. It can be used
/// in data tables or lists to visually indicate the sorting direction (ascending
/// or descending) and the active state of the sorting.
class SortIcon extends StatelessWidget {

  /// Indicates whether the sorting order is ascending.
  final bool ascending;

  /// Indicates whether the sort icon is active.
  final bool active;

  /// Creates a sort icon widget.
  ///
  /// Parameters:
  /// - [key]: An optional key to identify this widget.
  /// - [ascending]: A boolean value indicating whether the sorting order is ascending.
  /// - [active]: A boolean value indicating whether the sort icon is active.
  const SortIcon({
    super.key,
    required this.ascending,
    required this.active
  });

  /// Builds the widget tree for this sort icon.
  ///
  /// Returns:
  /// A Widget representing the sort icon
  @override
  Widget build(BuildContext context) {
    return Icon(
      ascending ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
      size: 28,
      color: active ? Colors.black : Colors.black12,
    );
  }
}