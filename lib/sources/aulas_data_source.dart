import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:data_table_2/data_table_2.dart';

class AulasDataSource extends DataTableSource {

  final BuildContext context;
  late List<ClassModel> aulas;
  final List<bool> visibleColumns;

  AulasDataSource(
      {required this.context, required this.aulas, required this.visibleColumns});

  @override
  DataRow2 getRow(int index) {
    assert (index >= 0);
    assert (index < aulas.length);
    final aula = aulas[index];
    return DataRow2.byIndex(
      index: index,
      selected: false,
      cells: [
        ...dataCells(aula),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => aulas.length;

  @override
  // TODO: If needed in the future, implement properly
  int get selectedRowCount => 0;

  List<DataCell> dataCells(ClassModel aula) {
    List<DataCell> returnList = [];
    for(int i = 0; i < aula.getPropertiesList().length; i++){
      if(visibleColumns[i]){
        returnList.add(DataCell(Text(aula.getPropertiesList()[i])));
      }
    }
    return returnList;
  }

}
