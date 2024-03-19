import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/sources/sources.dart';
import 'widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:collection/collection.dart';

class AulasPaginatedTable extends StatefulWidget {
  const AulasPaginatedTable(
      {super.key, required this.aulas, required this.columnNames, required this.searchLogic, required this.hiddenColumns});

  final List<ClassModel> aulas;
  final List<String> columnNames;
  final List<bool> hiddenColumns;
  final bool searchLogic;

  @override
  State<AulasPaginatedTable> createState() {
    return _MyPaginatedTableState();
  }
}

class _MyPaginatedTableState extends State<AulasPaginatedTable> {

  late List<ClassModel> currentAulas;
  late List<bool> ascending;
  late List<bool> active;
  late bool searchLogic;
  Map<String, dynamic> funcList = {};

  @override
  void initState() {
    super.initState();
    searchLogic = widget.searchLogic;
    ascending = List.filled(widget.columnNames.length, false);
    active = List.filled(widget.columnNames.length, false);
    active[0] = true;
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
    if (oldWidget.searchLogic != widget.searchLogic){
      setState(() {
        searchLogic = widget.searchLogic;
        currentAulas = widget.aulas;
      });
    }
  }

  ///Searches all columns with AND and logic
  void searchAndLogic(int index, String value, bool Function(ClassModel) comparatorFunc) {
    if (value == "") {
      funcList.remove(index.toString());
    } else {
      funcList.remove(index.toString());
      funcList.addAll({index.toString(): comparatorFunc});
    }

    //print(funcList);
    List<ClassModel> newCurrentAulas = List.from(widget.aulas);
    //print(newCurrentAulas.length);
    for (var comparatorFunc in funcList.entries) {
      newCurrentAulas.removeWhere(comparatorFunc.value);
      //print(newCurrentAulas.length);
    }
    setState(() {
      currentAulas = newCurrentAulas;
    });
  }
  ///Searches all cokumns with an OR logic
  void searchOrLogic(int index, String value, bool Function(ClassModel) comparatorFunc){
    if (value == ""){
      funcList.remove(index.toString());
    }else{
      funcList.remove(index.toString());
      funcList.addAll({index.toString() : comparatorFunc});
    }
    List<ClassModel> newCurrentAulas = [];
    for (var comparatorFunc in funcList.entries){
      List<ClassModel> tempList = List.from(widget.aulas);
      tempList.removeWhere(comparatorFunc.value);
      newCurrentAulas.addAll(tempList);
    }
    setState(() {
      currentAulas = newCurrentAulas.toSet().toList(); //remove duplicates
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
        ...widget.columnNames.mapIndexed((index, columnName) {
          return DataColumn(
            label: MyDataColumnLabel(
              text: columnName,
              onChanged: (value){
                searchLogic ? searchOrLogic(index, value, (element) => !element.getPropertiesList()[index].contains(value)) : searchAndLogic(index, value, (element) => !element.getPropertiesList()[index].contains(value));
              },
              onTap: (){
                genericOnTap(index, (a, b) => a.getPropertiesList()[index].compareTo(b.getPropertiesList()[index]));
              },
              active: active[index],
              ascending: ascending[index],
              searchLogic: searchLogic,
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
