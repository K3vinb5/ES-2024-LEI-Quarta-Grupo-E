import 'package:graphview/GraphView.dart';

import 'subject_model.dart';

/// A custom node model representing a node in a graph.
///
/// This class extends the [Node] class and represents a node with additional
/// properties such as [text] and [disciplina]. It is used to model nodes in a graph.
class MyNodeModel extends Node{

  /// The text associated with the node.
  final String text;

  /// The subject model associated with the node.
  final SubjectModel disciplina;

  /// Constructs a [MyNodeModel] instance.
  ///
  /// The [text] parameter specifies the text associated with the node.
  /// The [disciplina] parameter specifies the subject model associated with the node.
  /// The [id] parameter specifies the unique identifier of the node.
  MyNodeModel(this.text, this.disciplina, int id) : super.Id(id);

}