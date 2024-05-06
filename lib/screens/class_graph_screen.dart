import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:calendario_iscte/models/models.dart';

class ClassGraphViewScreen extends StatefulWidget {
  const ClassGraphViewScreen({super.key, required this.classes});

  final List<ClassModel> classes;

  @override
  _ClassGraphViewScreenState createState() => _ClassGraphViewScreenState();
}

class _ClassGraphViewScreenState extends State<ClassGraphViewScreen> {
  late List<ClassModel> classes;
  List<SubjectModel> subjects = [];
  Graph graph = Graph();
  Map<String, Node> nodeList = {};
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  @override
  void didUpdateWidget(covariant ClassGraphViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.classes != widget.classes) {
      setState(() {
        builder = SugiyamaConfiguration();
        classes = widget.classes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    classes = widget.classes;
    subjects = SubjectModel.subjectsFromClassModelsList(classes);

    int index = 0;

    for (int i = 0; i < subjects.length - 1; i++) {
      if (hasOverlap(subjects[i].times, subjects[i + 1].times)) {
        MyNodeModel? originNode;
        MyNodeModel? endNode;
        //startNode
        if (!nodeList.containsKey(subjects[i].name)) {
          originNode = MyNodeModel(subjects[i].name, subjects[i], index++);
          nodeList.addAll({subjects[i].name: originNode});
        } else {
          originNode = nodeList[subjects[i].name] as MyNodeModel?;
        }
        //endNode
        if (!nodeList.containsKey(subjects[i + 1].name)) {
          endNode = MyNodeModel(subjects[i + 1].name, subjects[i + 1], index++);
          nodeList.addAll({subjects[i + 1].name: endNode});
        } else {
          endNode = nodeList[subjects[i + 1].name] as MyNodeModel?;
        }
        //print("Edge: ${subjects[i].name} - ${subjects[i+1].name}");
        graph.addEdge(originNode!, endNode!);
        graph.addEdge(endNode, originNode);
      }
    }

    builder.nodeSeparation = 10;
    builder.levelSeparation = 30;
    builder.bendPointShape = CurvedBendPointShape(curveLength: 20);
    builder.orientation = SugiyamaConfiguration.DEFAULT_ORIENTATION;
    builder.coordinateAssignment = CoordinateAssignment.Average;
  }

  bool hasOverlap(List<dynamic> list1, List<dynamic> list2) {
    for (var element in list1) {
      if (list2.contains(element)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        classes.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ainda no importou o .csv das Aulas, por favor importe-o "),
                ],
              )
            : Expanded(
                child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(10000),
                  minScale: 0.8,
                  maxScale: 2.5,
                  child: GraphView(
                    graph: graph,
                    algorithm: SugiyamaAlgorithm(builder),
                    paint: Paint()
                      ..color = Colors.black
                      ..strokeWidth = 2
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      //var a = node.key!.value as int?;
                      var myNode = node as MyNodeModel;
                      return rectangleWidget(myNode.text);
                    },
                  ),
                ),
              ),
      ],
    );
  }

  Widget rectangleWidget(String s) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text(s));
  }
}
