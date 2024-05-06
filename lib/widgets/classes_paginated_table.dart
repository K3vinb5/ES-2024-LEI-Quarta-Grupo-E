import 'package:calendario_iscte/main.dart';
import 'package:flutter/material.dart';
import 'package:calendario_iscte/models/models.dart';
import 'package:calendario_iscte/sources/sources.dart';
import 'widgets.dart';
import 'package:data_table_2/data_table_2.dart';

/// A paginated table widget for displaying classes (aulas).
///
/// This widget displays classes (aulas) in a paginated table format. It allows
/// users to navigate through multiple pages of data and provides options for
/// hiding columns based on user preferences.
class ClassesPaginatedTable extends StatefulWidget {

  /// Creates a paginated table widget for displaying classes.
  ///
  /// The [key] parameter is an optional key to identify this widget.
  /// The [classes] parameter is the list of classes to display.
  /// The [columnNames] parameter is the list of column names for the table.
  /// The [visibleColumns] parameter is a list indicating the visibility of columns.
  /// The [hideColumn] parameter is a callback function to hide a column.
  /// The [searchLogic] parameter specifies the search logic to use.
  const ClassesPaginatedTable({
    super.key,
    required this.classes,
    required this.columnNames,
    required this.searchLogic,
    required this.visibleColumns,
    required this.hideColumn,
  });

  /// The list of classes (aulas) to display.
  final List<ClassModel> classes;

  /// The list of column names for the table.
  final List<String> columnNames;

  /// A list indicating the visibility of columns.
  final List<bool> visibleColumns;

  /// Callback function to hide a column.
  final void Function(int) hideColumn; //Callback

  /// Specifies the search logic to use.
  final bool searchLogic;

  @override
  State<ClassesPaginatedTable> createState() {
    return _MyPaginatedTableState();
  }
}

/// The state for the AulasPaginatedTable widget.
///
/// This state class manages the state of the AulasPaginatedTable widget,
/// including the current list of classes (aulas), column sorting, and search logic.
class _MyPaginatedTableState extends State<ClassesPaginatedTable> {

  /// The current list of classes displayed in the table.
  late List<ClassModel> currentClasses;

  /// List indicating whether each column is sorted in ascending order
  late List<bool> ascending;

  /// List indicating whether each column is visible.
  late List<bool> visible;

  /// List indicating whether each column is active (selected for sorting).
  late List<bool> active;

  /// List indicating whether each column is visible in the table.
  late List<bool> visibleColumns;

  /// Flag indicating whether the search logic is 'AND' or 'OR'.
  late bool searchLogic;

  /// Map storing functions for searching columns based on user input.
  Map<String, dynamic> funcList = {};

  /// Initializes the state when the widget is first created.
  ///
  /// Initializes [searchLogic] and [visibleColumns] based on the widget's properties.
  /// Sets [ascending] and [active] lists, with the first column being active by default.
  /// Sets [currentClasses] to the list of classes provided by the widget.
  @override
  void initState() {
    super.initState();
    searchLogic = widget.searchLogic;
    visibleColumns = widget.visibleColumns;
    //generated based on the amount of columns
    ascending = List.filled(widget.columnNames.length, false);
    active = List.filled(widget.columnNames.length, false);
    active[0] = true;
    setState(() {
      currentClasses = widget.classes;
    });
  }

  /// Called whenever the widget configuration is updated.
  ///
  /// Compares the properties of the old and new widgets to determine if any
  /// changes occurred.
  /// If the list of classes (`aulas`) or search logic (`searchLogic`) has
  /// changed, updates the state accordingly.
  /// If the visibility of columns (`visibleColumns`) has changed, updates the
  /// state to reflect the changes.
  @override
  void didUpdateWidget(covariant ClassesPaginatedTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    //aulas
    if (oldWidget.classes != widget.classes) {
      setState(() {
        currentClasses = widget.classes;
      });
    }
    //search logic (E and OU logic)
    if (oldWidget.searchLogic != widget.searchLogic) {
      setState(() {
        searchLogic = widget.searchLogic;
        currentClasses = widget.classes;
      });
    }
    //resets based on dropdown in screen
    if (oldWidget.visibleColumns != widget.visibleColumns) {
      setState(() {
        visibleColumns = widget.visibleColumns;
      });
    }
  }


  /// Searches all columns with 'AND' logic.
  ///
  /// Updates the state with the filtered list of classes.
  ///
  /// Parameters:
  /// - [index]: Used to remove previous searches with specified index
  /// - [value]: If provided adds new search function for the column
  /// - [comparatorFunc]: Comparator function to use for the comparison
  void searchAndLogic(
      int index, String value, bool Function(ClassModel) comparatorFunc) {
    if (value == "") {
      funcList.remove(index.toString());
    } else {
      funcList.remove(index.toString());
      funcList.addAll({index.toString(): comparatorFunc});
    }

    print(funcList);
    List<ClassModel> newCurrentAulas = List.from(widget.classes);
    //print(newCurrentAulas.length);
    for (var comparatorFunc in funcList.entries) {
      newCurrentAulas.removeWhere(comparatorFunc.value);
      //print(newCurrentAulas.length);
    }
    setState(() {
      currentClasses = newCurrentAulas;
    });
  }

  /// Searches all columns with an 'OR' logic.
  ///
  /// Updates the state with the filtered list of classes, removing duplicates.
  ///
  /// Parameters:
  /// - [index]: Used to remove previous searches with specified index
  /// - [value]: If provided adds new search function for the column
  /// - [comparatorFunc]: Comparator function to use for the comparison
  void searchOrLogic(
      int index, String value, bool Function(ClassModel) comparatorFunc) {
    if (value == "") {
      funcList.remove(index.toString());
    } else {
      funcList.remove(index.toString());
      funcList.addAll({index.toString(): comparatorFunc});
    }
    List<ClassModel> newCurrentAulas = [];
    for (var comparatorFunc in funcList.entries) {
      List<ClassModel> tempList = List.from(widget.classes);
      tempList.removeWhere(comparatorFunc.value);
      newCurrentAulas.addAll(tempList);
    }
    setState(() {
      currentClasses = newCurrentAulas.toSet().toList(); //remove duplicates
    });
  }

  /// Handles the tap event for a column header.
  ///
  /// Sets the active state for the tapped column and updates the sorting order.
  /// Reverses the sorting order if the column is already active.
  /// Sorts the list of classes (`currentAulas`) based on the provided comparator function.
  ///
  /// Parameters:
  /// - [index]: Activates a column from given index
  /// - [compareTo]: function used to sort in desired order
  void genericOnTap(int index, int Function(ClassModel, ClassModel) compareTo) {
    setState(() {
      for (int i = 0; i < active.length; i++) {
        active[i] = false;
      }
      active[index] = true;
      ascending[index] = !ascending[index];
      currentClasses.sort((a, b) {
        if (ascending[index]) {
          return compareTo(a, b);
        } else {
          return -1 * compareTo(a, b);
        }
      });
    });
  }

  /// Generates a list of DataColumn widgets for the table columns.
  ///
  /// Returns:
  /// A list of DataColumns for the table columns
  List<DataColumn> columns() {
    List<DataColumn> returnList = [];
    for (int i = 0; i < widget.columnNames.length; i++) {
      if (visibleColumns[i]) {
        returnList.add(DataColumn(
          label: MyDataColumnLabel(
            text: widget.columnNames[i],
            hideColumn: (){widget.hideColumn(i);},
            onChanged: (value) {
              searchLogic
                  ? searchOrLogic(
                      i,
                      value,
                      (element) =>
                          !element.getPropertiesList()[i].contains(value))
                  : searchAndLogic(
                      i,
                      value,
                      (element) =>
                          !element.getPropertiesList()[i].contains(value));
            },
            onTap: () {
              genericOnTap(
                  i,
                  (a, b) => a
                      .getPropertiesList()[i]
                      .compareTo(b.getPropertiesList()[i]));
            },
            active: active[i],
            ascending: ascending[i],
            searchLogic: searchLogic,
          ),
        ));
      }
    }
    return returnList;
  }

  /// Builds the widget tree for the paginated data table.
  ///
  /// Returns a PaginatedDataTable widget configured with the specified properties
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      isHorizontalScrollBarVisible: false,
      rowsPerPage: 15,
      headingRowHeight: 140,
      columnSpacing: 20,
      headingRowColor: const MaterialStatePropertyAll(
        Color.fromARGB(128, 147, 204, 238),
      ),
      headingRowDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      columns: [
        ...columns(),
      ],
      source: ClassesDataSource(
        updateState: (change) {
          setState(() {
            change();
            globalClasses = currentClasses;
          });
        },
        context: context,
        classes: currentClasses,
        visibleColumns: visibleColumns,
      ),
    );
  }
}
