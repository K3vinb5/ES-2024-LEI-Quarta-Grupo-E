import 'package:calendario_iscte/main.dart';
import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/widgets/widgets.dart';

class ClassroomOcupationScreen extends StatefulWidget {
  const ClassroomOcupationScreen({super.key, required this.classRooms});

  final List<ClassRoomModel> classRooms;

  @override
  State<ClassroomOcupationScreen> createState() =>
      _ClassroomOcupationScreenState();
}

class _ClassroomOcupationScreenState extends State<ClassroomOcupationScreen> {
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
