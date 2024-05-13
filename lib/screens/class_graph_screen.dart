import 'package:calendario_iscte/main.dart';
import 'package:calendario_iscte/widgets/style/styled_button.dart';
import 'package:calendario_iscte/widgets/style/styled_textfield.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:calendario_iscte/models/models.dart';

class ClassGraphViewScreen extends StatefulWidget {
  const ClassGraphViewScreen({super.key, required this.classes});

  final List<ClassModel> classes;

  @override
  State<ClassGraphViewScreen> createState() => _ClassGraphViewScreenState();
}

class _ClassGraphViewScreenState extends State<ClassGraphViewScreen> {
  late List<ClassModel> classes;
  List<SubjectModel> subjects = [];
  Graph graph = Graph();
  Map<String, Node> nodeList = {};
  SugiyamaConfiguration builder = SugiyamaConfiguration();
  TextEditingController textFieldController = TextEditingController();
  TransformationController transformationController = TransformationController();

  @override
  void didUpdateWidget(covariant ClassGraphViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.classes != widget.classes) {
      setState(() {
        rebuildGraph(widget.classes);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rebuildGraph(widget.classes);
  }

  bool hasOverlap(List<dynamic> list1, List<dynamic> list2) {
    for (var element in list1) {
      if (list2.contains(element)) {
        return true;
      }
    }
    return false;
  }

  void rebuildGraph(List<ClassModel> newClasses, {String? search}) {
    builder = SugiyamaConfiguration();
    classes = newClasses;
    subjects = SubjectModel.subjectsFromClassModelsList(classes);
    nodeList.clear();
    graph = Graph();
    Map<int, bool> validNeighbour = {};
    int index = 0;


    for (int i = 0; i < subjects.length - 1; i++) {
      if (hasOverlap(subjects[i].times, subjects[i + 1].times)) {
        MyNodeModel? originNode;
        MyNodeModel? endNode;
        if(search != null && ((subjects[i].name.contains(search) || subjects[i + 1].name.contains(search)) || (validNeighbour[i] ?? false))){
          validNeighbour.addAll({(i + 1) : true});
        }else{
          if(search != null){
            continue;
          }
        }
        //startNode
          if (!nodeList.containsKey(subjects[i].name)) {
            originNode = MyNodeModel(subjects[i].name, subjects[i], index++);
            nodeList.addAll({subjects[i].name: originNode});
          } else {
            originNode = nodeList[subjects[i].name] as MyNodeModel?;
          }
        //endNode
          if (!nodeList.containsKey(subjects[i + 1].name)) {
            endNode =
                MyNodeModel(subjects[i + 1].name, subjects[i + 1], index++);
            nodeList.addAll({subjects[i + 1].name: endNode});
          } else {
            endNode = nodeList[subjects[i + 1].name] as MyNodeModel?;
          }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        classes.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Ainda no importou o .csv das Aulas, por favor importe-o "),
                  SizedBox(
                    width: 200,
                    child: StyledButton(
                        onPressed: () {
                          setState(() {
                            rebuildGraph(globalClasses);
                          });
                        },
                        text: "Refresh",
                        icon: Icons.refresh),
                  ),
                ],
              )
            : Expanded(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    InteractiveViewer(
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(double.infinity),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          StyledTextField(
                            width: 250,
                            controller: textFieldController,
                            color: Colors.indigo,
                            textColor: Colors.black,
                            hintColor: Colors.grey,
                            hint: "Search...",
                          ),
                          StyledButton(
                              onPressed: () {
                                setState(() {
                                  if (textFieldController.text != ""){
                                    rebuildGraph(globalClasses, search: textFieldController.text);
                                  }else{
                                    rebuildGraph(globalClasses);
                                  }
                                });
                              },
                              text: "Search",

                              icon: Icons.search,
                            width: 150,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                StyledButton(
                                    onPressed: () {
                                      setState(() {
                                        rebuildGraph(globalClasses);
                                      });
                                    },
                                    text: "Refresh",
                                    icon: Icons.refresh),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
