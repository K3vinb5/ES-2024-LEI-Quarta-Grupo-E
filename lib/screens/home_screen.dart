import 'package:flutter/material.dart';

/// A screen widget representing the home screen of the application.
///
/// This widget serves as the main screen of the application.
/// It extends [StatefulWidget] to manage its mutable state.
class HomeScreen extends StatefulWidget {

  /// Constructs a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// The state for managing the UI and data of the [HomeScreen] widget.
///
/// This state class is responsible for managing the state of the home screen widget,
/// including its initialization and the build method for rendering the UI.
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  /// Builds the Widget's UI
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 900,
            child: Image.network(
              "https://conhecimentoinovacao.iscte-iul.pt/wp-content/uploads/2021/02/rgb_iscte_pt_horizontal_positive.png",
            ),
          ),
          const SizedBox(height: 100), // Spacer
          // Title Widget
          const Text(
            'Bem-vindo ao Calendário ISCTE-IUL',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Spacer
          // Description Widget
          const Text(
            'Nesta aplicação é possível visualizar horários e estatísticas de salas através da importação de ficheiros, é possível também ver um grafo para visualização de conflictualidade entre aulas',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
