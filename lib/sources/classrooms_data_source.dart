import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:data_table_2/data_table_2.dart';

/// A data source for a data table displaying classes (aulas).
///
/// This class implements the [DataTableSource] interface to provide data
/// for displaying classes in a data table. It contains methods to retrieve
/// individual rows of data and to determine the total number of rows.
class ClassRoomsDataSource extends DataTableSource {

  /// The build context.
  final BuildContext context;

  /// The list of classRooms (salas) to display
  late List<ClassRoomModel> classRooms;

  /// The list indicating the visibility of columns
  final List<bool> visibleColumns;

  /// This function gets inherited by the screen so we can update the ui when updating any value
  final void Function(Function) updateState;

  /// Creates a data source for the salas data table.
  ///
  /// The [context] parameter specifies the build context.
  /// The [classRooms] parameter is the list of classes to display.
  /// The [visibleColumns] parameter is a list indicating the visibility of columns.
  ClassRoomsDataSource({required this.context, required this.classRooms, required this.visibleColumns, required this.updateState});

  /// An instance of the ClassRoomModel class representing the current class room being processed.
  late ClassRoomModel thisClassRoom;

  ///An instance of TextEditingController used for controlling an editable text field widget.
  /// It allows for editing the text displayed in the text field and listening to changes made to the text.
  final TextEditingController _textFieldController = TextEditingController();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => classRooms.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow2 getRow(int index) {
    assert (index >= 0);
    assert (index < classRooms.length);
    thisClassRoom = classRooms[index];
    return DataRow2.byIndex(
      index: index,
      selected: false,
      cells: [
        ...dataCells(thisClassRoom, index),
      ],
    );
  }

  /// Generates a list of data cells for a given class room and index.
  ///
  /// This method generates a list of data cells for a given class room and index,
  /// based on the visible columns specified by the [visibleColumns] parameter.
  /// Each data cell contains an editable text field that allows editing the corresponding property value.
  List<DataCell> dataCells(ClassRoomModel thisClassRoom, int index) {
    List<DataCell> returnList = [];
    for(int i = 0; i < thisClassRoom.getPropertiesList().length; i++){
      if(visibleColumns[i]){
        returnList.add(
          DataCell(
            InkWell(
              onTap: () {
                _textFieldController.text = thisClassRoom.getPropertiesList()[i];
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edit Value"),
                      backgroundColor: const Color.fromARGB(255, 197,223,243),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            TextField(
                              controller: _textFieldController,
                            ),
                            const Expanded(child: Column(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                StyledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: "Cancel",
                                  icon: Icons.cancel_outlined,
                                  width: MediaQuery.of(context).size.width * 0.1,
                                ),
                                StyledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    updateState(() {
                                      thisClassRoom.setProperty(
                                          i, _textFieldController.text);
                                    });
                                  },
                                  text: "Confirm",
                                  icon: Icons.check,
                                  width: MediaQuery.of(context).size.width * 0.1,
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
                thisClassRoom.getPropertiesList()[i],
              ),
            ),
          ),
        );
      }
    }
    return returnList;
  }

}
