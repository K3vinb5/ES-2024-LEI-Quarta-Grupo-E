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
  List<Aula> aulas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ///UI of class
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TODO Buttons (Do Styled Button Widget on another file!!)
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
