import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/sources/sources.dart';
import 'widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:collection/collection.dart';

class AulasPaginatedTable extends StatefulWidget {
  const AulasPaginatedTable(
      {super.key, required this.aulas});

  final List<ClassModel> aulas;

  @override
  State<AulasPaginatedTable> createState() {
    return _MyPaginatedTableState();
  }
}

class _MyPaginatedTableState extends State<AulasPaginatedTable> {

  late List<ClassModel> currentAulas;

  List<String> columnNames = ["Curso", "UC", "Turno", "Turma", "Inscritos", "Dia", "Início", "Fim", "Data", "Características", "Sala"];
  List<bool> ascending = [false, false, false, false, false, false, false, false, false, false, false];
  List<bool> active = [true, false, false, false, false, false, false, false, false, false, false];

  Map<String, dynamic> funcList = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      currentAulas = widget.aulas;
    });
  }

  @override
  void didUpdateWidget(covariant AulasPaginatedTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.aulas != widget.aulas){
      setState(() {
        currentAulas = widget.aulas;
      });
    }
  }


  void genericOnChange(int index, String value, bool Function(ClassModel) whereFunc) {
    if (value == "") {
      funcList.remove(index.toString());
    } else {
      funcList.remove(index.toString());
      funcList.addAll({index.toString(): whereFunc});
    }

    //print(funcList);
    List<ClassModel> newCurrentAulas = List.from(widget.aulas);
    //print(newCurrentAulas.length);
    for (var whereFunc in funcList.entries) {
      newCurrentAulas.removeWhere(whereFunc.value);
      //print(newCurrentAulas.length);
    }
    setState(() {
      currentAulas = newCurrentAulas;
    });
  }


  void genericOnTap(int index, int Function(ClassModel, ClassModel) compareTo) {
    setState(() {
      for (int i = 0; i < active.length; i++) {
        active[i] = false;
      }
      active[index] = true;
      ascending[index] = !ascending[index];
      currentAulas.sort((a, b) {
        if (ascending[index]) {
          return compareTo(a, b);
        } else {
          return -1 * compareTo(a, b);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      isHorizontalScrollBarVisible: false,
      rowsPerPage: 15,
      headingRowHeight: 100,
      columnSpacing: 20,
      headingRowColor: const MaterialStatePropertyAll(
        Color.fromARGB(128, 147, 204, 238),
      ),
      headingRowDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      columns: [
        ...columnNames.mapIndexed((index, columnName) {
          return DataColumn(
            label: MyDataColumnLabel(
              text: columnName,
              onChanged: (value){
                genericOnChange(index, value, (element) => !element.getPropertiesList()[index].contains(value));
              },
              onTap: (){
                genericOnTap(index, (a, b) => a.getPropertiesList()[index].compareTo(b.getPropertiesList()[index]));
              },
              active: active[index],
              ascending: ascending[index],
            ),
          );
        }),
      ],
      source: AulasDataSource(
        context: context,
        aulas: currentAulas,
      ),
    );
  }
}
