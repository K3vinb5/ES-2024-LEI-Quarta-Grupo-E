import 'package:calendario_iscte/models/models.dart';

/// A model representing a subject.
///
/// This class represents a subject, including its [name], [times], and [days].
/// It provides methods for generating subject models from a list of class models
/// and converting the subject model to a string representation.
class SubjectModel {

  /// Constructs a [SubjectModel] instance.
  ///
  /// The [name] parameter specifies the name of the subject.
  /// The [times] parameter specifies the times associated with the subject.
  SubjectModel({required this.name, required this.times});

  /// The name of the subject.
  final String name;

  /// The times associated with the subject.
  late final List<String> times;

  /// The days associated with the subject.
  late final List<String> days;

  /// Generates a list of subject models from a list of class models.
  ///
  /// The [classes] parameter specifies the list of class models.
  /// It returns a list of subject models extracted from the class models.
  static List<SubjectModel> subjectsFromClassModelsList(List<ClassModel> classes) {
    List<SubjectModel> subjects = [];
    Map<String, List<String>> classesMap = {};

    for (ClassModel newClass in classes) {
      if (classesMap.containsKey(newClass.curricularUnit)) {
        classesMap.update(newClass.curricularUnit, (list) {
          if (!list.contains("${newClass.initTime}-${newClass.finalTime}:${newClass.dayOfTheWeek}")) {
            list.add("${newClass.initTime}-${newClass.finalTime}:${newClass.dayOfTheWeek}");
          }
          return list;
        });
      } else {
        classesMap.addAll({
          newClass.curricularUnit: ["${newClass.initTime}-${newClass.finalTime}:${newClass.dayOfTheWeek}"]
        });
      }
    }
    for (int i = 0; i < classesMap.length; i++) {
      subjects.add(SubjectModel(
          name: classesMap.keys.toList()[i], times: classesMap.values.toList()[i]));
    }
    return subjects;
  }

  @override
  String toString() {
    return "$name $times\n";
  }

}
