import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

/// The main entry point for the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatefulWidget {

  /// Constructs a [MyApp] widget.
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// The state class for the [MyApp] widget.
class _MyAppState extends State<MyApp> {

  /// List of screens in the application.
  List<Widget> screens = [const MainScreen()];

  /// List of titles corresponding to each screen
  List<String> screensTitle = [
    "Main Screen",
    "Screen 2",
    "Screen 3",
    "Screen 4",
    "Screen 5"
  ];

  /// Index of the currently active screen.
  int currentScreenIndex = 0;

  /// Widget representing the current screen.
  late Widget currentScreen;

  /// Title of the current screen.
  late String currentScreenTitle;

  /// Overrides the [initState] method to initialize the state of the widget.
  @override
  void initState() {
    super.initState();
    currentScreen = screens[currentScreenIndex];
    currentScreenTitle = screensTitle[currentScreenIndex];
  }

  /// Builds the UI of the application.
  ///
  /// Returns:
  /// A new root widget for the application to be built upon
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendário Iscte',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: Scaffold(
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
              ...screensTitle.map((title) {
                return DrawerComponent(
                  text: title,
                  onTap: () {},
                );
              })
            ],
          ),
        ),
        body: currentScreen,
      ),
    );
  }
}
