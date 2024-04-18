import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:data_table_2/data_table_2.dart';

/// A data source for a data table displaying classes (aulas).
///
/// This class implements the [DataTableSource] interface to provide data
/// for displaying classes in a data table. It contains methods to retrieve
/// individual rows of data and to determine the total number of rows.
class ClassesDataSource extends DataTableSource {

  /// The build context.
  final BuildContext context;

  /// The list of classes (aulas) to display
  late List<ClassModel> aulas;

  /// The list indicating the visibility of columns
  final List<bool> visibleColumns;

  /// Creates a data source for the aulas data table.
  ///
  /// The [context] parameter specifies the build context.
  /// The [aulas] parameter is the list of classes to display.
  /// The [visibleColumns] parameter is a list indicating the visibility of columns.
  ClassesDataSource(
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