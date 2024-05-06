import 'package:flutter/material.dart';

import 'package:calendario_iscte/models/models.dart';

class SubjectModel {
  ///Do not use
  SubjectModel({required this.name, required this.times});

  final String name;
  late final List<String> times;
  late final List<String> days;

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
    return "${name} ${times}\n";
  }

}
