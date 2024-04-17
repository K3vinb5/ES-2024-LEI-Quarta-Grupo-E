import 'package:csv/csv.dart';

/// This model represents all data related to a class
class ClassModel {

  /// Stores the degree assigned to this class
  late String degree;

  /// Stores the curricular unit assigned to this class
  late String curricularUnit;

  /// Stores the shift assigned to this class
  late String shift;

  /// Stores the class name
  late String className;

  /// Stores the number of students enrolled in this class
  late int enrolled;

  /// Stores the day of the week in which this class is given
  late String dayOfTheWeek;

  /// Stores the starting time of this class
  late String initTime;

  /// Stores the ending time of this class
  late String finalTime;

  /// Stores the date in which this class is given
  late String date;

  /// Stores any other characteristics related to this class
  late String characteristics;

  /// Stores the class room in which this class is given
  late String room;

  /// ClassModel constructor
  ClassModel({
    required this.degree,
    required this.curricularUnit,
    required this.shift,
    required this.className,
    required this.enrolled,
    required this.dayOfTheWeek,
    required this.initTime,
    required this.finalTime,
    required this.date,
    required this.characteristics,
    required this.room,
  });

  /// Constructor from a dynamic list (this is used in order to make compatibility
  /// with the csv format provided)
  /// Parameters:
  /// - [list]: List of dynamic type that contains the information needed to
  /// construct a new ClassModel
  /// Returns:
  /// A Class Model with the given information
  ClassModel.fromDynamicList(List<dynamic> list){
    degree          = list[0];
    curricularUnit  = list[1];
    shift           = list[2];
    className       = list[3];
    enrolled        = list[4];
    dayOfTheWeek    = list[5];
    initTime        = list[6];
    finalTime       = list[7];
    date            = list[8];
    characteristics = list[9];
    room            = list[10].toString();
  }

  /// Converts a list of lists of dynamic objects (csv representation) into a
  /// list of classes
  /// Parameters:
  /// - [list]: List of Lists of dynamic type (csv representation)
  /// Returns:
  /// A list of classes converted from the given input
  static List<ClassModel> getClasses(List<List<dynamic>> list){
    List<ClassModel> returnList = [];

    for (var value in list) {
      returnList.add(ClassModel.fromDynamicList(value));
    }

    return returnList;
  }

  /// Creates a dynamic type list with all the properties from the class model
  /// Returns:
  /// A List (dynamic typing) of the class attributes
  List<dynamic> getPropertiesList(){
    List<dynamic> list = [];
    list.add(degree);
    list.add(curricularUnit);
    list.add(shift);
    list.add(className);
    list.add(enrolled.toString());
    list.add(dayOfTheWeek);
    list.add(initTime);
    list.add(finalTime);
    list.add(date);
    list.add(characteristics);
    list.add(room);

    return list;
  }

  /// Converts a list of classes into a csv string
  /// Parameters:
  /// - [list]: List of Classes
  /// Returns:
  /// A csv string with the class parameters
  static String toCsv(List<ClassModel> list){
    List<List<dynamic>> toConvert = [];
    toConvert.add(["Curso","Unidade Curricular","Turno","Turma","Inscritos no turno"
      ,"Dia da semana","Hora início da aula","Hora fim da aula","Data da aula",
      "Características da sala pedida para a aula","Sala atribuída à aula"]);

    for (var value in list) {
      toConvert.add(value.getPropertiesList());
    }

    return const ListToCsvConverter(fieldDelimiter: ";").convert(toConvert);
  }

  /// Implementation of default method toJson in order to represent an object of
  /// the ClassModel type and its attributes
  /// Returns:
  /// A JSON Map that for any given key as the attributed value
  Map<String, dynamic> toJson(){
    return {
      "curso" : degree,
      "uc" : curricularUnit,
      "turno" : shift,
      "turma" : className,
      "inscritos" : enrolled,
      "diaDaSemana" : dayOfTheWeek,
      "initTime" : initTime,
      "finalTime" : finalTime,
      "date" : date,
      "characteristics" : characteristics,
      "sala" : room,
    };
  }

  /// Creates a string with all the classes parameters separated by spaces
  /// (debug and readability purposes)
  @override
  String toString() {
    return "$degree $curricularUnit $shift $className $enrolled $dayOfTheWeek "
        "$initTime $finalTime $date $characteristics $room";
  }
}