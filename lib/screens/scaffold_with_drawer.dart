import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:collection/collection.dart';

/// A scaffold widget with a drawer for navigation.
///
/// This widget provides a scaffold layout with a drawer for navigation.
/// It takes a [navigationShell] parameter of type [StatefulNavigationShell]
/// to manage the navigation within the application.
class ScaffoldWithDrawer extends StatefulWidget {

  /// Constructs a [ScaffoldWithDrawer] widget.
  ///
  /// The [navigationShell] parameter is required and specifies the navigation
  /// shell used to manage navigation within the application.
  const ScaffoldWithDrawer({super.key, required this.navigationShell});

  /// The navigation shell used to manage navigation within the application.
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithDrawer> createState() => _ScaffoldWithDrawerState();
}

/// The state for managing the UI and data of the [ScaffoldWithDrawer] widget.
///
/// This state class is responsible for managing the state of the scaffold with
/// a drawer widget, including the titles of different screens and handling navigation.
class _ScaffoldWithDrawerState extends State<ScaffoldWithDrawer> {

  /// The titles of the screens displayed in the drawer.
  List<String> screensTitle = [
    "Início",
    "Ecrã Aulas",
    "Ecrã Salas",
    "Ecrã Grafo",
    "Ecrã Ocupação"
  ];

  /// The title of the currently active screen.
  String currentScreenTitle = "Tela Aulas";

  /// Handles navigation to different screens.
  ///
  /// This method is called when an item in the drawer is tapped. It navigates
  /// to the corresponding screen based on the tapped index.
  ///
  /// The [context] parameter represents the build context of the widget.
  /// The [index] parameter specifies the index of the screen to navigate to.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white, //Changes drawer color
        title: Text(
          currentScreenTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.35,
        child: ListView(
          children: [
            const DrawerTitle(),
            ...screensTitle.mapIndexed((index, title) {
              return DrawerComponent(
                text: title,
                onTap: () {
                  _onTap(context, index);
                  Navigator.pop(context);
                  currentScreenTitle = screensTitle[index];
                },
              );
            })
          ],
        ),
      ),
      body: widget.navigationShell,
    );
  }
}
