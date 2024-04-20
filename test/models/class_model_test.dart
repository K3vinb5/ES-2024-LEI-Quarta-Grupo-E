import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calendario_iscte/models/class_model.dart';

/// Builds a default instance of [ClassModel] with predefined values.
///
/// This function creates an instance of [ClassModel] with predefined values for its
/// properties. It then returns the created instance.
///
/// Return:
/// - An instance of [ClassModel] with predefined values.
ClassModel buildDefaultClassModel() {
  final classModel = ClassModel(degree: "LEI", curricularUnit: "IPM", shift:
  "16:00 to 17:30", className: "Introduce PM", enrolled: 1, dayOfTheWeek:
  "Friday", initTime: "16:00", finalTime: "17:30", date: "17/04/2024",
      characteristics: "Boring", room: "C203");

  return classModel;
}

void main() {

  group('ClassModel Testing Suit', () {

    /// Tests initialization of [ClassModel] with given values.
    ///
    /// Verifies that a [ClassModel] instance is correctly initialized with specific
    /// values for its properties. It asserts that each property matches the expected
    /// value.
    ///
    /// Test Parameters:
    /// - [degree]: The degree associated with the class model.
    /// - [curricularUnit]: The curricular unit associated with the class model.
    /// - [shift]: The shift of the class model.
    /// - [className]: The name of the class associated with the class model.
    /// - [enrolled]: The number of enrolled students for the class model.
    /// - [dayOfTheWeek]: The day of the week for the class model.
    /// - [initTime]: The initial time of the class model.
    /// - [finalTime]: The final time of the class model.
    /// - [date]: The date of the class model instance.
    /// - [characteristics]: The characteristics of the class model.
    /// - [room]: The room associated with the class model.
    ///
    /// Test Assertions:
    /// - Verifies that the given list is passed on to the ClassModel creator
    /// and returned with the given information
    test('Initialization With Given Values', () {
      final classModel = buildDefaultClassModel();

      expect(classModel.room, "C203");
      expect(classModel.characteristics, "Boring");
      expect(classModel.date, "17/04/2024");
      expect(classModel.finalTime, "17:30");
      expect(classModel.initTime, "16:00");
      expect(classModel.dayOfTheWeek, "Friday");
      expect(classModel.enrolled, 1);
      expect(classModel.className, "Introduce PM");
      expect(classModel.shift, "16:00 to 17:30");
      expect(classModel.curricularUnit, "IPM");
      expect(classModel.degree, "LEI");
    });

    /// Tests initialization of [ClassModel] with blank values.
    ///
    /// Verifies that a [ClassModel] instance is correctly initialized with specific
    /// values for its properties. It asserts that each property matches the expected
    /// value.
    ///
    /// Test Assertions:
    /// - Verifies that the blank values are passed on to the ClassModel creator
    /// and returned with the given information (blank)
    test('Initialization With Blank Values', () {
      final classModel = ClassModel(degree: "", curricularUnit: "", shift:
      "", className: "", enrolled: 0, dayOfTheWeek: "", initTime: "", finalTime:
      "", date: "", characteristics: "", room: "");

      expect(classModel.room, "");
      expect(classModel.characteristics, "");
      expect(classModel.date, "");
      expect(classModel.finalTime, "");
      expect(classModel.initTime, "");
      expect(classModel.dayOfTheWeek, "");
      expect(classModel.enrolled, 0);
      expect(classModel.className, "");
      expect(classModel.shift, "");
      expect(classModel.curricularUnit, "");
      expect(classModel.degree, "");
    });

    /// Tests dynamic list allocation for [ClassModel].
    ///
    /// Verifies that a [ClassModel] instance is correctly created from a dynamic
    /// list of values. It asserts that each property of the created instance
    /// matches the corresponding value from the input list.
    ///
    /// Test Assertions:
    /// - Verifies that the given list is passed on to the ClassModel creator
    /// and returned with the given information
    test('Test Dynamic List Allocation', () {
      List<dynamic> list = [
        "ME",
        "Teoria dos Jogos e dos Contratos",
        "01789TP01",
        "MEA1",
        30,
        "Qua",
        "13:00:00",
        "14:30:00",
        "23/11/2022",
        "Sala Aulas Mestrado",
        "AA2.25"
      ];

      final classModel = ClassModel.fromDynamicList(list);

      expect(classModel.room, "AA2.25");
      expect(classModel.characteristics, "Sala Aulas Mestrado");
      expect(classModel.date, "23/11/2022");
      expect(classModel.finalTime, "14:30:00");
      expect(classModel.initTime, "13:00:00");
      expect(classModel.dayOfTheWeek, "Qua");
      expect(classModel.enrolled, 30);
      expect(classModel.className, "MEA1");
      expect(classModel.shift, "01789TP01");
      expect(classModel.curricularUnit, "Teoria dos Jogos e dos Contratos");
      expect(classModel.degree, "ME");
    });

    /// Tests dynamic object conversion to [ClassModel] using data from a CSV file.
    ///
    /// This test case reads the contents of a CSV file located at 'test/testCSV.csv'
    /// and converts it into a list of lists of dynamic objects using the
    /// `CsvToListConverter` from the `csv` package.
    ///
    /// Test Parameters:
    /// - [csv]: A string containing the CSV data read from the file.
    /// - [list]: A list of lists of dynamic objects representing the CSV data.
    /// - [classes]: A list of [ClassModel] instances converted from the CSV data.
    ///
    /// Test Assertions:
    /// - Verifies that the number of [ClassModel] instances created matches the expected value.
    /// - Verifies that the `curricularUnit` property of the [ClassModel]
    /// instances matches the expected values.
    test('GetClasses tests dynamic object conversion to Class Model', () async {
      String csv = await File('test/testRoomCSV.csv').readAsString();

      List<List<dynamic>> list = const CsvToListConverter(fieldDelimiter: ";")
          .convert(csv);
      
      list.removeAt(0);
      
      List<ClassModel> classes = ClassModel.getClasses(list);
      
      expect(classes.length, 26019);
      expect(classes[0].curricularUnit, "Teoria dos Jogos e dos Contratos");
    });

    /// Tests the `getPropertiesList` method of the [ClassModel] class by using
    /// model assertions.
    ///
    /// This test case verifies that the `getPropertiesList` method of the [ClassModel]
    /// class correctly returns a list of properties in a specific order.
    ///
    /// Test Parameters:
    /// - [classModel]: An instance of [ClassModel] initialized with predefined values.
    /// - [propertiesList]: A list of properties obtained from the [ClassModel] instance using
    ///   the `getPropertiesList` method.
    ///
    /// Test Assertions:
    /// - Verifies that each property in the obtained list matches the expected value at the
    ///   corresponding index.
    test('GetPropertiesList tests by using model assertions', () {
      final classModel = buildDefaultClassModel();

      List<dynamic> propertiesList = classModel.getPropertiesList();

      expect(propertiesList[10], "C203");
      expect(propertiesList[9], "Boring");
      expect(propertiesList[8], "17/04/2024");
      expect(propertiesList[7], "17:30");
      expect(propertiesList[6], "16:00");
      expect(propertiesList[5], "Friday");
      expect(propertiesList[4], "1");
      expect(propertiesList[3], "Introduce PM");
      expect(propertiesList[2], "16:00 to 17:30");
      expect(propertiesList[1], "IPM");
      expect(propertiesList[0], "LEI");
    });

    /// Tests the `toCsv` method of the [ClassModel] class by using a predefined instance.
    ///
    /// This test case verifies that the `toCsv` method of the [ClassModel] class correctly
    /// converts a list of class instances into a CSV representation.
    ///
    /// Test Parameters:
    /// - [classModel]: A predefined instance of [ClassModel] used for testing.
    /// - [classModelList]: A list containing the predefined instance of [ClassModel].
    /// - [csv]: A string representing the CSV representation of the class instance list.
    /// - [expectedString]: The expected CSV string.
    ///
    /// Test Assertion:
    /// - Verifies that the obtained CSV string matches the expected CSV string.
    test('toCSV method by using the predefined classModel', () {
      final classModel = buildDefaultClassModel();

      List<ClassModel> classModelList = [classModel];

      String csv = ClassModel.toCsv(classModelList);

      String expectedString = "Curso;Unidade Curricular;Turno;Turma;Inscritos no "
          "turno;Dia da semana;Hora início da aula;Hora fim da aula;Data da aula;"
          "Características da sala pedida para a aula;Sala atribuída à aula\r\n"
          "LEI;IPM;16:00 to 17:30;Introduce PM;1;Friday;16:00;17:30;17/04/2024;Boring;C203";

      expect(csv, expectedString);
    });

    /// Tests the `toJson` method of the [ClassModel] class by using a predefined instance.
    ///
    /// This test case verifies that the `toJson` method of the [ClassModel] class
    /// correctly converts a class instance into a JSON representation.
    ///
    /// Test Parameters:
    /// - [classModel]: A predefined instance of [ClassModel] used for testing.
    /// - [json]: A map representing the JSON representation of the class instance.
    /// - [keysList]: An iterable containing the keys extracted from the JSON map.
    /// - [valuesList]: An iterable containing the values extracted from the JSON map.
    /// - [expectedKeys]: A list of expected keys in the JSON representation.
    /// - [expectedValues]: A list of expected values in the JSON representation.
    ///
    /// Test Assertions:
    /// - Verifies that the keys extracted from the JSON map match the expected keys.
    /// - Verifies that the values extracted from the JSON map match the expected values.
    test('toJson method by using the predefined classModel', () {
      final classModel = buildDefaultClassModel();

      Map<String, dynamic> json = classModel.toJson();

      Iterable<String> keysList = json.keys;
      Iterable<dynamic> valuesList = json.values;

      List<String> expectedKeys = ["curso", "uc", "turno", "turma", "inscritos",
      "diaDaSemana", "initTime", "finalTime", "date", "characteristics", "sala"];
      List<dynamic> expectedValues = ["LEI", "IPM", "16:00 to 17:30", "Introduce PM",
      1, "Friday", "16:00", "17:30", "17/04/2024", "Boring", "C203"];

      int i = 0;
      for(var key in keysList) {
        expect(key, expectedKeys[i++]);
      }

      i = 0;
      for(var value in valuesList) {
        expect(value, expectedValues[i++]);
      }
    });

    /// Tests the `toString` method of the [ClassModel] class to ensure it correctly
    /// prints the values of class properties.
    ///
    /// This test case verifies that the `toString` method of the [ClassModel] class
    /// correctly formats and prints the values of its properties.
    ///
    /// Test Parameters:
    /// - [classModel]: An instance of [ClassModel] initialized with predefined values.
    ///
    /// Test Assertion:
    /// - Verifies that the string representation of the class model matches the expected
    ///   format containing all property values concatenated with spaces.
    test('toString method correctly prints the class models values', () {
      final classModel = buildDefaultClassModel();

      expect(classModel.toString(), "LEI IPM 16:00 to 17:30 Introduce PM 1 Friday 16:00 17:30 17/04/2024 Boring C203");
    });

  });


}