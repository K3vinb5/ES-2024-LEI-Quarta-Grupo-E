import 'package:calendario_iscte/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/screens.dart';
import 'models/models.dart';

/// The main entry point for the application.
void main() {
  runApp(const MyApp());
}

List<ClassModel> globalClasses = [];
List<ClassRoomModel> globalClassRooms = [];

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _classesNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'classes');
final GlobalKey<NavigatorState> _classRoomsNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'classRooms');
final GlobalKey<NavigatorState> _graphNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'classGraph');
final GlobalKey<NavigatorState> _occupationNavigationKey =
GlobalKey<NavigatorState>(debugLabel: 'classRoomsOccupation');
final GlobalKey<NavigatorState> _homeNavigationKey =
GlobalKey<NavigatorState>(debugLabel: 'home');

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldWithDrawer(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _homeNavigationKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/home',
              builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _classesNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/classes',
              builder: (BuildContext context, GoRouterState state) =>
              const ClassesScreen(),
            ),
          ],
        ),

        // The route branch for the second tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _classRoomsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/classRooms',
              builder: (BuildContext context, GoRouterState state) =>
              const ClassRoomsScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _graphNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/classGraph',
              builder: (BuildContext context, GoRouterState state) =>
              ClassGraphViewScreen(classes: globalClasses),
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _occupationNavigationKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/classRoomOccupation',
              builder: (BuildContext context, GoRouterState state) =>
              ClassroomOcupationScreen(classRooms: globalClassRooms,),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// The root widget of the application.
class MyApp extends StatefulWidget {

  /// Constructs a [MyApp] widget.
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// The state class for the [MyApp] widget.
class _MyAppState extends State<MyApp> {

  /// Builds the UI of the application.
  ///
  /// Returns:
  /// A new root widget for the application to be built upon
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Iscte Calendar',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
    );
  }
}