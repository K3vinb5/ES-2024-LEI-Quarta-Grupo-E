import 'package:calendario_iscte/widgets/style/styled_button.dart';
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
  late List<ClassModel> classes;

  /// The list indicating the visibility of columns
  final List<bool> visibleColumns;

  /// This function gets inherited by the screen so we can update the ui when updating any value
  final void Function(Function) updateState;

  final void Function(bool) updateButtonText;

  /// Creates a data source for the aulas data table.
  ///
  /// The [context] parameter specifies the build context.
  /// The [classes] parameter is the list of classes to display.
  /// The [visibleColumns] parameter is a list indicating the visibility of columns.
  ClassesDataSource({
    required this.context,
    required this.classes,
    required this.visibleColumns,
    required this.updateState,
    required this.updateButtonText,
  });

  late ClassModel thisClass;
  bool selected = false;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => classes.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    assert(index < classes.length);
    thisClass = classes[index];
    return DataRow2.byIndex(
      index: index,
      selected: false,
      cells: [
        ...dataCells(thisClass, index),
      ],
    );
  }

  List<DataCell> dataCells(ClassModel thisClass, int index) {
    List<DataCell> returnList = [];
    for (int i = 0; i < thisClass.getPropertiesList().length; i++) {
      if (visibleColumns[i]) {
        returnList.add(
          DataCell(
            InkWell(
              onTap: () {
                _textFieldController.text = thisClass.getPropertiesList()[i];
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edit Value"),
                      backgroundColor: const Color.fromARGB(255, 197, 223, 243),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _textFieldController,
                            ),
                            const Expanded(
                              child: Column(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                StyledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: "Cancel",
                                  icon: Icons.cancel_outlined,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                StyledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    updateState(() {
                                      thisClass.setProperty(
                                          i, _textFieldController.text);
                                    });
                                  },
                                  text: "Confirm",
                                  icon: Icons.check,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                thisClass.getPropertiesList()[i],
              ),
            ),
          ),
        );
      }
    }
    returnList.add(DataCell(StatefulBuilder(
      builder: (context, setState) {
        return Checkbox(
          value: selected,
          onChanged: (value) {
            setState(() {
              selected = !selected;
            });
            updateState(() {
              updateButtonText(selected);
            });
          },
        );
      },
    )));
    return returnList;
  }
}
