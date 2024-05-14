import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:calendario_iscte/main.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/dialogs/dialogs.dart';
import 'package:collection/collection.dart';

/// A screen widget for displaying class rooms information.
///
/// This widget is a screen that displays information about class rooms.
/// It extends [StatefulWidget] to manage its mutable state.
class ClassRoomsScreen extends StatefulWidget {

  /// Constructs a [ClassRoomsScreen] widget.
  const ClassRoomsScreen({super.key});

  @override
  State<ClassRoomsScreen> createState() => _ClassRoomsScreenState();
}

/// The state for managing the UI and data of the [ClassRoomsScreen] widget.
///
/// This state class is responsible for managing the state of the screen widget,
/// including the list of class room models and column names for display.
class _ClassRoomsScreenState extends State<ClassRoomsScreen> {

  /// The list of class room models to be displayed.
  List<ClassRoomModel> classRooms = [];

  /// The list of column names for display.
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
    visibleColumns = [
      ...List.filled(5, true),
      ...List.filled(columnNames.length - 5, false)
    ];
    for (int i = 5; i < columnNames.length; i++) {
      hideColumn(i);
    }
  }

  /// Imports local CSV files and updates the class room data accordingly.
  ///
  /// This method prompts the user to select a local CSV file using a file picker.
  /// It reads the CSV file, parses its contents, and updates the class room data
  /// with the parsed information.
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
        globalClassRooms = ClassRoomModel.getClassRooms(list);
      });
    }
  }

  /// Imports online CSV files from the provided URL and updates the class room data accordingly.
  ///
  /// This method takes a URL as input, fetches the CSV file from the URL using HTTP GET request,
  /// parses its contents, and updates the class room data with the parsed information.
  /// If the content type of the response is not CSV, it displays a dialog indicating the error.
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
            globalClassRooms = ClassRoomModel.getClassRooms(list);
          });
        } else {
          noCsvDialog();
        }
      }
    } catch (_) {
      noCsvDialog();
    }
  }

  /// Exports class room data to a CSV file.
  ///
  /// This method prompts the user to select an output file location using a file picker.
  /// It converts the class room data to CSV format and writes it to the selected file.
  void exportToCSV() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'Salas.csv',
    );

    if (outputFile == null) {
      // User canceled the picker
    } else {
      String csv = ClassRoomModel.toCsv(classRooms);
      File f = File(outputFile);
      f.writeAsString(csv);
      final exPath = f.path;
      await File(exPath).create(recursive: true);
    }
  }

  /// Exports class room data to a JSON file.
  ///
  /// This method prompts the user to select an output file location using a file picker.
  /// It converts the class room data to JSON format and writes it to the selected file.
  void exportToJSON() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'Salas.json',
    );

    if (outputFile == null) {
      // User canceled the picker
    } else {
      String json = jsonEncode(classRooms);
      File f = File(outputFile);
      f.writeAsString(json);
      final exPath = f.path;
      await File(exPath).create(recursive: true);
    }
  }

  /// Displays a dialog indicating that the file format is not CSV.
  ///
  /// This method displays an alert dialog indicating that the file format is not CSV.
  void noCsvDialog(){
    showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Not a csv")),);
  }

  /// Opens a save dialog for exporting class room data.
  ///
  /// This method displays a custom save dialog where the user can choose to export
  /// the class room data either to a CSV file or a JSON file.
  void openSaveDialog(){
    showDialog(context: context, builder: (context) => SaveFileDialog(onTap1: exportToCSV, onTap2: exportToJSON, title: 'Guardar Ficheiro Salas',),);
  }

  /// Hides a column in the class room data table.
  ///
  /// This method updates the visibility of a column in the class room data table.
  /// It sets the visibility of the column at the specified [index] to false and adds
  /// the column name to the list of hidden column names.
  void hideColumn(int index) {
    setState(() {
      visibleColumns[index] = false;
      hiddenColumnNames.add(columnNames[index]);
    });
  }

  /// Builds the Widget's UI
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
                Text("  Lógica E"),
                Text("  Lógica OU"),
              ],
              horizontalPadding: 10,
              onTap: (index) {
                setState(() {
                  searchLogic = index == 0 ? false : true;
                  searchLogicDropDownValue = index;
                });
              },
              width: 200,
              changeValue: true,
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
                }),
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
              text: "Guardar alterações",
              width: 200,
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
