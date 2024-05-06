import 'package:graphview/GraphView.dart';

import 'subject_model.dart';

class MyNodeModel extends Node{

  final String text;
  final SubjectModel disciplina;
  MyNodeModel(this.text, this.disciplina, int id) : super.Id(id);

}