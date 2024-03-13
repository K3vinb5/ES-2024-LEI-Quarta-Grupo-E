import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> screens = [const MainScreen()];
  List<String> screensTitle = [
    "Main Screen",
    "Screen 2",
    "Screen 3",
    "Screen 4",
    "Screen 5"
  ];

  int currentScreenIndex = 0;
  late Widget currentScreen;
  late String currentScreenTitle;

  @override
  void initState() {
    super.initState();
    currentScreen = screens[currentScreenIndex];
    currentScreenTitle = screensTitle[currentScreenIndex];
  }

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
