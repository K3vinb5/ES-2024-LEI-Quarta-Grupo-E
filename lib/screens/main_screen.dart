import 'dart:io';

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
  late List<Aula> aulas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void importFiles() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String csv = await file.readAsString();
      List<List<dynamic>> list = const CsvToListConverter().convert(csv);
      setState(() {
        aulas = Aula.getAulas(list);
      });
    }

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
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: AulasPaginatedTable(
                        aulas: aulas,
                        currentAulas: aulas,
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
