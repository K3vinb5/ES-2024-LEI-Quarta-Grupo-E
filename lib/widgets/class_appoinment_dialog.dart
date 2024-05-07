import 'package:flutter/material.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:collection/collection.dart';

class ClassAppointmentDialog extends StatefulWidget {
  const ClassAppointmentDialog({super.key, required this.title});

  final String title;

  @override
  State<ClassAppointmentDialog> createState() => _ClassAppointmentDialogState();
}

class _ClassAppointmentDialogState extends State<ClassAppointmentDialog> {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  String fromTime = "08:00";
  String toTime = "08:00";
  final List<String> weekDays = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];
  final List<String> fromClassesTimes = [
    "08:00",
    "09:30",
    "11:00",
    "12:30",
    "13:00",
    "14:30",
    "14:30",
    "16:00",
    "17:30",
    "18:00",
    "19:30",
    "19:30",
    "21:00",
    "21:00",
    "22:30"
  ];
  final List<String> toClassesTimes = [
    "08:00",
    "09:30",
    "11:00",
    "12:30",
    "13:00",
    "14:30",
    "14:30",
    "16:00",
    "17:30",
    "18:00",
    "19:30",
    "19:30",
    "21:00",
    "21:00",
    "22:30"
  ];

  List<Color> weekColors = List.filled(6, Colors.grey);

  List<Widget> listTimings(List<String> times) {
    return times
        .map(
          (time) => Text(time),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 210, 233, 253),
      title: Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Intervalo de Dias
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Escolha um Intervalo de Dias"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      StyledTextField(
                        width: 200,
                        controller: fromDate,
                        color: Colors.indigo,
                        hintColor: Colors.grey,
                        readOnly: true,
                        hint: "Desde",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      StyledTextField(
                        width: 200,
                        controller: toDate,
                        color: Colors.indigo,
                        hintColor: Colors.grey,
                        readOnly: true,
                        hint: "Até",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        onPressed: () async {
                          DateTimeRange? range = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.utc(2022, 01, 01),
                              lastDate: DateTime.now());
                          if (range == null) {
                            return;
                          }
                          fromDate.text = range.start.toString();
                          toDate.text = range.end.toString();
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              //Dias da Semana Pretendidos
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Escolha os dias disponíveis"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ...weekDays.mapIndexed(
                        (index, element) {
                          return Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 100,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: weekColors[index],
                                  ),
                                  child: Center(
                                    child: Text(
                                      element,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    weekColors[index] == Colors.indigo
                                        ? weekColors[index] = Colors.grey
                                        : weekColors[index] = Colors.indigo;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Escolha um intervalo de horas"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StyledDropDown(
                        hint: "Hora Início",
                        horizontalPadding: 10,
                        width: 200,
                        changeValue: true,
                        items: listTimings(fromClassesTimes),
                        onTap: (index) {
                          fromTime = fromClassesTimes[index];
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StyledDropDown(
                        hint: "Hora Fim",
                        horizontalPadding: 10,
                        width: 200,
                        changeValue: true,
                        items: listTimings(toClassesTimes),
                        onTap: (index) {
                          toTime = toClassesTimes[index];
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
