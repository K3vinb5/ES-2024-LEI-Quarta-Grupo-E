import 'dart:convert';
import 'dart:io';
import 'package:calendario_iscte/main.dart';
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:calendario_iscte/models/models.dart';

/// Represents the main screen of the application.
///
/// This widget serves as the main screen of the application. It's a stateful widget
/// that can hold mutable state and can be rebuilt when the state changes.
class ClassesScreen extends StatefulWidget {
  /// Creates the main screen widget.
  ///
  /// The [key] parameter is an optional key to identify this widget.
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

/// The state for the main screen widget.
///
/// This stateful widget manages the state for the main screen of the application.
/// It contains lists of classes, column names, and other properties necessary
/// for rendering the user interface.
class _ClassesScreenState extends State<ClassesScreen> {
  /// List of classes imported by the user.
  List<ClassModel> classes = [];

  /// Static list of column names.
  List<String> columnNames = [
    "Curso",
    "UC",
    "Turno",
    "Turma",
    "Inscritos",
    "Dia",
    "Início",
    "Fim",
    "Data",
    "Características",
    "Sala",
    "Semana do \nAno",
    "Semana do \nSemestre"
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
    super.initState();
    visibleColumns = List.filled(columnNames.length, true);
  }

  /// Imports files asynchronously.
  ///
  /// This method allows the user to import files. It prompts the user to select
  /// a file, reads the file contents as a CSV string, converts the CSV string
  /// into a list of lists, and then updates the state with the list of classes.
  void importLocalFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String csv = await file.readAsString();
      List<List<dynamic>> list =
          const CsvToListConverter(fieldDelimiter: ";").convert(csv);
      list.removeAt(0);
      setState(() {
        classes = ClassModel.getClasses(list);
        globalClasses = ClassModel.getClasses(list);
      });
    }
  }

  /// Imports CSV file data from the provided URL and updates the state with the parsed data.
  ///
  /// Parameters:
  /// - [url]: parameter specifies the URL of the CSV file to import.
  ///
  /// Throws an error if the HTTP request fails or if the response status code is not 200 (OK).
  /// If the content type of the response is 'text/csv', the CSV data is decoded as UTF-8
  /// and parsed into a list of lists using a ';' as the field delimiter. The first
  /// row (header) is removed from the parsed data.
  ///
  /// The parsed data is used to instantiate [ClassModel] objects, and the state
  /// is updated with the resulting list of classes.
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
            classes = ClassModel.getClasses(list);
            globalClasses = ClassModel.getClasses(list);
          });
        } else {
          print("Not a CSV");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void exportToCSV() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'Horário.csv',
    );

    if (outputFile == null) {
      // User canceled the picker
    } else {
      String csv = ClassModel.toCsv(classes);
      File f = File(outputFile);
      f.writeAsString(csv);
      final exPath = f.path;
      await File(exPath).create(recursive: true);
    }
  }

  void exportToJSON() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'Horário.json',
    );

    if (outputFile == null) {
      // User canceled the picker
    } else {
      String json = jsonEncode(classes);
      File f = File(outputFile);
      f.writeAsString(json);
      final exPath = f.path;
      await File(exPath).create(recursive: true);
    }
  }

  void openSaveDialog(){
    showDialog(context: context, builder: (context) => SaveFileDialog(onTap1: exportToCSV, onTap2: exportToJSON, title: 'Guardar Ficheiro Aulas',),);
  }
  
  void openAppointmentClassDialog(){
    showDialog(context: context, builder: (context) => const ClassAppointmentDialog(title: "Marcação de Aulas"),);
  }

  /// Hides the column at the specified index.
  ///
  /// This method hides the column at the specified index by updating the
  /// [visibleColumns] list and adding the column name to the [hiddenColumnNames] list.
  ///
  /// Parameters:
  /// - [index]: int value of the index to hide
  void hideColumn(int index) {
    setState(() {
      visibleColumns[index] = false;
      hiddenColumnNames.add(columnNames[index]);
    });
  }

  /// Builds the user interface for the main screen.
  ///
  /// This method constructs the user interface for the main screen widget. It
  /// includes buttons for importing files, dropdowns for selecting search logic,
  /// and a paginated table for displaying classes.
  ///
  /// Returns:
  /// A Widget representing the main UI elements of the application
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
            StyledDropDown(
              items: const [
                Text("Lógica E"),
                Text("Logica OU"),
              ],
              horizontalPadding: 10,
              onTap: (index) {
                setState(() {
                  searchLogic = index == 0 ? false : true;
                  searchLogicDropDownValue = index;
                });
              },
              width: 200,
            ),
            const SizedBox(
              width: 20,
            ),
            StyledDropDown(
              items: [
                ...hiddenColumnNames.mapIndexed((index, columnName) {
                  return Row(
                    children: [
                      Text(
                        columnName,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.remove_red_eye_outlined),
                    ],
                  );
                })
              ],
              horizontalPadding: 10,
              onTap: (index) {
                setState(() {
                  visibleColumns[
                          columnNames.indexOf(hiddenColumnNames[index])] =
                      true; //makes column visible again;
                  hiddenColumnNames.removeAt(index);
                });
              },
              width: 200,
            ),
            StyledButton(
              onPressed: () {
                openSaveDialog();
              },
              text: "Guardar Alterações",
              width: 200,
            ),
            StyledButton(
              onPressed: () {
                openAppointmentClassDialog();
              },
              text: "Marcar Aulas",
              width: 200,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClassesPaginatedTable(
                        classes: classes,
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
