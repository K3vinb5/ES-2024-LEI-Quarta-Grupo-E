import 'package:flutter/material.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:collection/collection.dart';

/// A dialog widget for class appointments.
///
/// This widget is a dialog that allows users to schedule class appointments.
/// It extends [StatefulWidget] to manage its mutable state.
class ClassAppointmentDialog extends StatefulWidget {

  /// Constructs a [ClassAppointmentDialog] widget.
  ///
  /// The [title] parameter is required and specifies the title of the dialog.
  const ClassAppointmentDialog({super.key, required this.title});

  /// The title of the dialog.
  final String title;

  @override
  State<ClassAppointmentDialog> createState() => _ClassAppointmentDialogState();
}

/// The state for managing the UI and data of the [ClassAppointmentDialog] widget.
///
/// This state class is responsible for managing the state of the dialog widget,
/// including text controllers for input fields, selected time slots, and room types.
class _ClassAppointmentDialogState extends State<ClassAppointmentDialog> {

  /// Controller for the 'from' date input field.
  TextEditingController fromDate = TextEditingController();

  /// Controller for the 'to' date input field.
  TextEditingController toDate = TextEditingController();

  /// Selected 'from' time slot.
  String fromTime = "08:00";

  /// Selected 'to' time slot.
  String toTime = "08:00";

  /// List of week days.
  final List<String> weekDays = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];

  /// List of available time slots for starting classes.
  final List<String> fromClassesTimes = [
    "08:00",
    "09:30",
    "11:00",
    "12:30",
    "13:00",
    "14:30",
    "16:00",
    "17:30",
    "18:00",
    "19:30",
    "21:00",
    "22:30"
  ];

  /// List of available time slots for ending classes.
  final List<String> toClassesTimes = [
    "08:00",
    "09:30",
    "11:00",
    "12:30",
    "13:00",
    "14:30",
    "16:00",
    "17:30",
    "18:00",
    "19:30",
    "21:00",
    "22:30"
  ];

  /// List of available class room types.
  final List<String> classRoomTypes = [
    "Selecione Tipos...",
    "Anfiteatro aulas",
    "Apoio técnico eventos",
    "Arq 1",
    "Arq 2",
    "Arq 3",
    "Arq 4",
    "Arq 5",
    "Arq 6",
    "Arq 9",
    "BYOD (Bring Your Own Device)",
    "Focus Group",
    "Horário sala visível portal público",
    "Laboratório de Arquitectura de Computadores I",
    "Laboratório de Arquitectura de Computadores II",
    "Laboratório de Bases de Engenharia",
    "Laboratório de Electrónica",
    "Laboratório de Informática",
    "Laboratório de Jornalismo",
    "Laboratório de Redes de Computadores I",
    "Laboratório de Redes de Computadores II",
    "Laboratório de Telecomunicações",
    "Sala Aulas Mestrado",
    "Sala Aulas Mestrado Plus",
    "Sala NEE",
    "Sala Provas",
    "Sala Reunião",
    "Sala de Arquitectura",
    "Sala de Aulas normal",
    "Videoconferência",
    "Átrio"
  ];

  /// List of indices representing selected class room types.
  List<int> selectedClassRoomTypesIndex = [];

  /// List of text styles for displaying class room types.
  late List<TextStyle> classRoomTypesTextStyles;

  /// List of selected time intervals.
  List<String> selectedIntervalTimes = [];

  /// List of colors for each day of the week.
  List<Color> weekColors = List.filled(6, Colors.grey);

  @override
  void initState() {
    super.initState();
    classRoomTypesTextStyles = List.filled(classRoomTypes.length, const TextStyle(color: Colors.black, fontWeight: FontWeight.normal));
  }

  /// Generates a list of widgets representing time slots.
  ///
  /// Each widget in the list displays a time slot.
  List<Widget> listTimings(List<String> times) {
    return times.map((time) => Text(time)).toList();
  }

  /// Generates a list of widgets representing selected time intervals.
  ///
  /// Each widget in the list displays a selected time interval.
  List<Widget> listSelectedTimeIntervals() {
    return selectedIntervalTimes
        .map((timeInterval) => Text(timeInterval))
        .toList();
  }

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 210, 233, 253),
      title: Text(
        widget.title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
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
                        textColor: Colors.black,
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
                        textColor: Colors.black,
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
                          fromDate.text =
                              "${range.start.day}/${range.start.month}/${range.start.year}";
                          toDate.text =
                              "${range.end.day}/${range.end.month}/${range.end.year}";
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
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            StyledDropDown(
                              items: listSelectedTimeIntervals(),
                              horizontalPadding: 10,
                              onTap: (index) {
                                setState(() {
                                  selectedIntervalTimes.removeAt(index);
                                });
                              },
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StyledButton(
                    onPressed: () {
                      if (/*toClassesTimes.indexOf(toTime) <= fromClassesTimes.indexOf(fromTime) &&*/ (fromClassesTimes
                                  .indexOf(toTime) -
                              toClassesTimes.indexOf(fromTime)) !=
                          1) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Error",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              content: Text(
                                  "Please use a valid class time interval"),
                            );
                          },
                        );
                        return;
                      }
                      String element = "$fromTime - $toTime";
                      setState(() {
                        if (!selectedIntervalTimes.contains(element)) {
                          selectedIntervalTimes.add(element);
                        }
                      });
                    },
                    text: "Adicionar Intervalo",
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Escolha caracteristicas das Salas (4 max)"),
                  const SizedBox(
                    height: 10,
                  ),
                  StyledDropDown(
                    horizontalPadding: 20,
                    items: [...classRoomTypes.mapIndexed((index, classRoomType) => Text(classRoomType, style: classRoomTypesTextStyles[index],))],
                    width: 200,
                    hint: "Caracteristicas",
                    changeValue: false,
                    onTap: (index){
                      if (index == 0){
                        return;
                      }
                      setState(() {
                        if (selectedClassRoomTypesIndex.contains(index - 1)){
                          classRoomTypesTextStyles[index] = const TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
                          selectedClassRoomTypesIndex.remove(index - 1);
                        }else{
                          if (selectedClassRoomTypesIndex.length > 3){
                            showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Escedeu o Limite", style: TextStyle(fontSize:23, fontWeight: FontWeight.bold),), content: Text("Excedeu o limite de 4 caracteristicas..."),),);
                            return;
                          }
                          selectedClassRoomTypesIndex.add(index - 1);
                          classRoomTypesTextStyles[index] = const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  const Text("Características Escolhidas:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...selectedClassRoomTypesIndex.map((index) => Text("${classRoomTypes[index + 1]}, ")),
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
