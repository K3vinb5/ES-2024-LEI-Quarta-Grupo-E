import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:data_table_2/data_table_2.dart';

class AulasDataSource extends DataTableSource {

  final BuildContext context;
  late List<Aula> aulas;

  AulasDataSource({required this.context, required this.aulas});

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
  // TODO: temp
  int get selectedRowCount => 0;

  List<DataCell> dataCells(aula){
    return List.generate(11, (index) => DataCell(Text(aula.getPropertiesList()[index])));
  }

}
