import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:collection/collection.dart';

class ClassRoomsScreen extends StatefulWidget {
  const ClassRoomsScreen({super.key});

  @override
  State<ClassRoomsScreen> createState() => _ClassRoomsScreenState();
}

class _ClassRoomsScreenState extends State<ClassRoomsScreen> {
  List<ClassRoomModel> classRooms = [];

  List<String> columnNames = [
    "Edifício",
    "Nome sala",
    "Capacidade Normal",
    "Capacidade Exame",
    "Nº Características",
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
    "Laboratório de \nArquitectura de Computadores I",
    "Laboratório de \nArquitectura de Computadores II",
    "Laboratório de \nBases de Engenharia",
    "Laboratório de Electrónica",
    "Laboratório de Informática",
    "Laboratório de Jornalismo",
    "Laboratório de \nRedes de Computadores I",
    "Laboratório de \nRedes de Computadores II",
    "Laboratório de \nTelecomunicações",
    "Sala Aulas Mestrado",
    "Sala Aulas Mestrado Plus",
    "Sala NEE",
    "Sala Provas",
    "Sala Reunião",
    "Sala de Arquitectura",
    "Sala de Aulas normal",
    "Videoconferência",
    "Átrio"
  ]; //static data

  /// List of boolean values indicating the visibility of columns.
  late List<bool> visibleColumns = [];

  /// List of names of hidden columns.
  List<String> hiddenColumnNames = [];

  /// Boolean flag indicating the search logic.
  bool searchLogic = false;

  /// Dropdown value for the search logic.
  int searchLogicDropDownValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visibleColumns = [...List.filled(5, true), ...List.filled(columnNames.length - 5, false)];
    for(int i = 5; i < columnNames.length; i++){
      hideColumn(i);
    }
  }

  void importLocalFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      //String csv = await file.readAsString();
      Uint8List? fileBytes = await file.readAsBytes();
      String csv = String.fromCharCodes(fileBytes.toList() as Iterable<int>);
      List<List<dynamic>> list =
          const CsvToListConverter(fieldDelimiter: ";").convert(csv);
      list.removeAt(0);
      setState(() {
        classRooms = ClassRoomModel.getClassRooms(list);
      });
    }
  }

  void importOnlineFiles(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Status code OK
        String? contentType = response.headers['content-type'];

        if (contentType?.toLowerCase().contains('text/csv') ?? false) {
          String csv = utf8.decode(response.body.runes.toList());

          List<List<dynamic>> list =
              const CsvToListConverter(fieldDelimiter: ";").convert(csv);

          list.removeAt(0);
          setState(() {
            classRooms = ClassRoomModel.getClassRooms(list);
          });
        } else {
          print("Not a CSV");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void hideColumn(int index){
    setState(() {
      visibleColumns[index] = false;
      hiddenColumnNames.add(columnNames[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StyledButton(
              onPressed: () {
                importLocalFiles();
              },
              text: "Importar ficheiro local",
              icon: Icons.folder_copy_rounded,
            ),
            StyledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InputDialog(
                      text: "Introduza uma URL",
                      onInputSubmitted: (String url) {
                        importOnlineFiles(url);
                      },
                    );
                  },
                );
              },
              text: "Importar ficheiro online",
              icon: Icons.wifi,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo),
              ),
              child: DropdownButton(
                alignment: Alignment.topCenter,
                focusColor: Colors.white,
                value: searchLogicDropDownValue,
                items: const [
                  DropdownMenuItem(
                    alignment: Alignment.centerLeft,
                    value: 0,
                    child: Text("  Lógica E"),
                  ),
                  DropdownMenuItem(
                    alignment: Alignment.centerLeft,
                    value: 1,
                    child: Text("  Lógica OU"),
                  ),
                ],
                onChanged: (index) {
                  setState(() {
                    searchLogic = index == 0 ? false : true;
                    searchLogicDropDownValue = index!;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo),
              ),
              child: DropdownButton(
                alignment: Alignment.topCenter,
                focusColor: Colors.white,
                value: searchLogicDropDownValue,
                items: [
                  ...hiddenColumnNames.mapIndexed((index, columnName) {
                    return DropdownMenuItem(
                      value: index,
                      child: Row(
                        children: [
                          Text(
                            columnName,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(Icons.remove_red_eye_outlined),
                        ],
                      ),
                    );
                  }),
                ],
                onChanged: (index) {
                  setState(() {
                    visibleColumns[
                            columnNames.indexOf(hiddenColumnNames[index!])] =
                        true; //makes column visible again;
                    hiddenColumnNames.removeAt(index);
                  });
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO Review this widget tree
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClassRoomsPaginatedTable(
                        classRooms: classRooms,
                        columnNames: columnNames,
                        visibleColumns: visibleColumns,
                        hideColumn: hideColumn,
                        searchLogic: searchLogic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
