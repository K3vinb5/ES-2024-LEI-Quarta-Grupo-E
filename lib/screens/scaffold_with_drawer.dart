import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calendario_iscte/widgets/widgets.dart';
import 'package:collection/collection.dart';

class ScaffoldWithDrawer extends StatefulWidget {
  const ScaffoldWithDrawer({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithDrawer> createState() => _ScaffoldWithDrawerState();
}

class _ScaffoldWithDrawerState extends State<ScaffoldWithDrawer> {
  List<String> screensTitle = [
    "Classes Screen",
    "ClassRooms Screen",
  ];
  String currentScreenTitle = "Classes Screen";

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
