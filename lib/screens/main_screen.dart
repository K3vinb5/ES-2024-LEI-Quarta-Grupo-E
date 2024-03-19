import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:calendario_iscte/models/models.dart';

///Classe's widget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  String get title {
    return "";
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

///Classe's State
class _MainScreenState extends State<MainScreen> {
  List<ClassModel> aulas = []; //To be imported by user
  List<String> columnNames = ["Curso", "UC", "Turno", "Turma", "Inscritos", "Dia", "Início", "Fim", "Data", "Características", "Sala"]; //static data
  late List<bool> visibleColumns = []; // visible columns, based on the amount of columns
  List<String> hiddenColumnNames = []; // Names of the hidden Columns
  bool searchLogic = false;
  int searchLogicDropDownValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visibleColumns = List.filled(columnNames.length, true);
  }

  void importFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String csv = await file.readAsString();
      List<List<dynamic>> list =
          const CsvToListConverter(fieldDelimiter: ";").convert(csv);
      list.removeAt(0);
      setState(() {
        aulas = ClassModel.getClasses(list);
      });
    }
  }
  
  void hideColumn(int index){
    setState(() {
    visibleColumns[index] = false;
    hiddenColumnNames.add(columnNames[index]);
    });
  }

  ///UI of class
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
                importFiles();
              },
              text: "Importar ficheiro local",
              icon: Icons.folder_copy_rounded,
            ),
            StyledButton(
              onPressed: () {},
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
                          const SizedBox(width: 20,),
                          const Icon(Icons.remove_red_eye_outlined),
                        ],
                      ),
                    );
                  }),
                ],
                onChanged: (index) {
                  setState(() {
                    visibleColumns[columnNames.indexOf(hiddenColumnNames[index!])] = true; //makes column visible again;
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
                      child: AulasPaginatedTable(
                        aulas: aulas,
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
