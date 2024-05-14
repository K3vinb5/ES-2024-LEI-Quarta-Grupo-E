import 'package:calendario_iscte/main.dart';
import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/widgets/widgets.dart';

/// A screen widget for displaying classroom occupation information.
///
/// This widget is a screen that displays information about classroom occupation.
/// It extends [StatefulWidget] to manage its mutable state.
class ClassroomOcupationScreen extends StatefulWidget {

  /// Constructs a [ClassroomOcupationScreen] widget.
  ///
  /// The [classRooms] parameter is required and specifies the list of class room models
  /// to be displayed in the screen.
  const ClassroomOcupationScreen({super.key, required this.classRooms});

  /// The list of class room models to be displayed in the screen.
  final List<ClassRoomModel> classRooms;

  @override
  State<ClassroomOcupationScreen> createState() =>
      _ClassroomOcupationScreenState();
}

/// The state for managing the UI and data of the [ClassroomOcupationScreen] widget.
///
/// This state class is responsible for managing the state of the screen widget,
/// including the list of class room models.
class _ClassroomOcupationScreenState extends State<ClassroomOcupationScreen> {

  /// The list of class room models to be displayed.
  late List<ClassRoomModel> classRooms;

  @override
  void initState() {
    super.initState();
    classRooms = widget.classRooms;
  }

  @override
  void didUpdateWidget(covariant ClassroomOcupationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.classRooms != widget.classRooms) {
      setState(() {
        classRooms = widget.classRooms;
      });
    }
  }

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        classRooms.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Ainda no importou o .csv das Salas, por favor importe-o "),
                  SizedBox(
                    width: 200,
                    child: StyledButton(
                        onPressed: () {
                          setState(() {
                            classRooms = globalClassRooms;
                          });
                        },
                        text: "Refresh",
                        icon: Icons.refresh),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
