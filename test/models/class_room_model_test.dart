import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calendario_iscte/models/class_room_model.dart';

/// Generates a default instance of [ClassRoomModel].
///
/// Returns a [ClassRoomModel] instance with default values for various properties.
ClassRoomModel buildDefaultClassModel() {
  final classModel = ClassRoomModel(building: "Edificio 2", roomName: "C505",
  normalCapacity: "40", examCapacity: "20", characteristicsNumber: "1", isAmphitheater: "",
  isTechSupportForEvents: "", isArq1: "", isArq2: "", isArq3: "",
  isArq4: "", isArq5: "", isArq6: "", isArq9: "", isBYOD: "",
  isFocusGroup: "", hasPublicSchedule: "", isFACLab1: "", isFACLab2: "",
  isBELab: "", isElectronicsLab: "", isComputerLab: "", isJournalismLab: "",
  isNetworkLab1: "", isNetworkLab2: "", isTelecommunicationsLab: "",
  isMastersRoom: "", isMastersRoomPlus: "", isNEERoom: "", isExamRoom: "",
  isReunionRoom: "", isArchitectureRoom: "", isNormalRoom: "X", hasVideoconferenceGear: "",
  isAtrium: "");

  return classModel;
}

void main() {

  group('ClassRoomModel Testing Suit', () {

    /// Test the initialization of a [ClassRoomModel] instance with default values.
    ///
    /// The test verifies that the instance is correctly initialized with the
    /// expected default values.
    test('Initialization With Given Values', () {
      final classRoomModel = buildDefaultClassModel();

      expect(classRoomModel.isNormalRoom, true);
      expect(classRoomModel.building, "Edificio 2");
      expect(classRoomModel.roomName, "C505");
      expect(classRoomModel.normalCapacity, "40");
      expect(classRoomModel.examCapacity, "20");
      expect(classRoomModel.isArchitectureRoom, false);
    });

    /// Not needed due to the fact that so little parameters can have blank
    /// information
    /// test('Initialization With Blank Values')

    /// Test the dynamic allocation of a [ClassRoomModel] instance from a list.
    ///
    /// The test validates that a [ClassRoomModel] instance is correctly allocated
    /// using a dynamic list, and that the properties of the instance match the
    /// expected values from the provided list.
    test('Test Dynamic List Allocation', () {
      List<dynamic> list = [
        "Edificio 2",
        "C505",
        "40",
        "20",
        "1",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "X",
        "",
        "",
      ];

      final classRoomModel = ClassRoomModel.fromDynamicList(list);

      expect(classRoomModel.isArchitectureRoom, false);
      expect(classRoomModel.building, "Edificio 2");
      expect(classRoomModel.roomName, "C505");
      expect(classRoomModel.normalCapacity, "40");
      expect(classRoomModel.examCapacity, "20");
      expect(classRoomModel.isNormalRoom, "X");
      expect(classRoomModel.isAtrium, "");
    });

    /// Test the conversion of dynamic objects to [ClassRoomModel] instances.
    ///
    /// The test reads a CSV file containing dynamic data, converts it into a list of lists,
    /// and then converts each inner list into a [ClassRoomModel] instance.
    /// It verifies that the conversion process is successful and that the properties of the
    /// resulting instances match the expected values.
    test('GetClasses tests dynamic object conversion to ClassRoomModel', () async {
      String csv = await File('test/testClassRoomCSV.csv').readAsString();

      List<List<dynamic>> list = const CsvToListConverter(fieldDelimiter: ";")
          .convert(csv);

      list.removeAt(0);

      List<ClassRoomModel> classes = ClassRoomModel.getClassRooms(list);

      expect(classes.length, 131);
      expect(classes[0].building, "Ala Autónoma (ISCTE-IUL)");
      expect(classes[0].examCapacity, "39");
    });

    /// Test the [getPropertiesList] method by validating the generated list of properties.
    ///
    /// This test initializes a [ClassRoomModel] instance with default values,
    /// retrieves the list of properties using the [getPropertiesList] method,
    /// and asserts that each property in the list matches the expected value.
    test('GetPropertiesList tests by using model assertions', () {
      final classRoomModel = buildDefaultClassModel();

      List<dynamic> propertiesList = classRoomModel.getPropertiesList();

      expect(propertiesList[0], "Edificio 2");
      expect(propertiesList[1], "C505");
      expect(propertiesList[2], "40");
      expect(propertiesList[3], "20");
      expect(propertiesList[4], "1");
      expect(propertiesList[34], "");
    });

    /// Test the [toCsv] method by validating the CSV string generated from a list of class models.
    ///
    /// This test initializes a [ClassRoomModel] instance with default values,
    /// creates a list of such instances, converts the list to a CSV string using the [toCsv] method,
    /// and asserts that the generated CSV string matches the expected format and content.
    test('toCSV method by using the predefined classRoomModel', () {
      final classModel = buildDefaultClassModel();

      List<ClassRoomModel> classModelList = [classModel];

      String csv = ClassRoomModel.toCsv(classModelList);

      String expectedString = "Edifício;Nome sala;Capacidade Normal;Capacidade Exame;"
      "Nº Características;Anfiteatro aulas;Apoio técnico eventos;Arq 1;Arq 2;Arq 3;"
      "Arq 4;Arq 5;Arq 6;Arq 9;BYOD (Bring Your Own Device);Focus Group;Horário sala visível portal público;"
      "Laboratório de Arquitectura de Computadores I;Laboratório de Arquitectura de Computadores II;"
      "Laboratório de Bases de Engenharia;Laboratório de Electrónica;Laboratório de Informática;"
      "Laboratório de Jornalismo;Laboratório de Redes de Computadores I;Laboratório de Redes de Computadores II;"
      "Laboratório de Telecomunicações;Sala Aulas Mestrado;Sala Aulas Mestrado Plus;"
      "Sala NEE;Sala Provas;Sala Reunião;Sala de Arquitectura;Sala de Aulas normal;"
      "videoconferência;Átrio\r\n"

      "Edificio 2;C505;40;20;1;false;false;false;false;false;false;false;false"
      ";false;false;false;false;false;false;false;false;false;false;false;false"
      ";false;false;false;false;false;false;false;true;false;false";

      expect(csv, expectedString);
    });

    /// Test the [toJson] method by validating the generated JSON map using the predefined classModel.
    ///
    /// This test initializes a [ClassRoomModel] instance with default values,
    /// converts it to a JSON map using the [toJson] method,
    /// and asserts that the generated JSON map contains the expected keys and values.
    test('toJson method by using the predefined classRoomModel', () {
      final classModel = buildDefaultClassModel();

      Map<String, dynamic> json = classModel.toJson();

      Iterable<String> keysList = json.keys;
      Iterable<dynamic> valuesList = json.values;

      List<String> expectedKeys = ["edifício", "nomeSala", "capacidadeNormal",
        "capacidadeExame", "numCaracteristicas", "anfiteatroAulas", "apoioTecnicoEventos",
        "arq1", "arq2", "arq3", "arq4", "arq5", "arq6", "arq9", "byod", "focusGroup",
        "horarioSalaVisivelPortalPublico", "laboratorioArquitectureDeComputadoresI",
        "laboratorioArquitectureDeComputadoresII", "laboratorioBasesDeEngenharia",
        "laboratorioEletronica", "laboratorioInformatica", "laboratorioJornalismo",
        "laboratorioRedesDeComputadoresI", "laboratorioRedesDeComputadoresII",
        "laboratorioTelecomunicacoes", "salaAulasMestrado", "salaAulasMestradoPlus",
        "salaNEE", "salaProvas", "salaReuniao", "salaArquitetura", "salaAulasNormal",
        "videoconferencia", "atrio"
      ];
      List<dynamic> expectedValues = ["Edificio 2","C505","40","20","1",false,
        false, false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false, false,
        false, false, false, false, true, false, false];

      int i = 0;
      for(var key in keysList) {
        expect(key, expectedKeys[i++]);
      }

      i = 0;
      for(var value in valuesList) {
        expect(value, expectedValues[i++]);
      }
    });

    /// Tests the `toString` method of the [ClassRoomModel] class to ensure it correctly
    /// prints the values of class properties.
    ///
    /// This test case verifies that the `toString` method of the [ClassRoomModel] class
    /// correctly formats and prints the values of its properties.
    ///
    /// Test Parameters:
    /// - [classRoomModel]: An instance of [ClassRoomModel] initialized with predefined values.
    ///
    /// Test Assertion:
    /// - Verifies that the string representation of the classroom model matches the expected
    ///   format containing all property values concatenated with spaces.
    test('toString method correctly prints the class room model\'s values', () {
      final classRoomModel = buildDefaultClassModel();

      expect(classRoomModel.toString(), "Edificio 2 C505 40 1 false false false false "
          "false false false false false false false false false false false false "
          "false false false false false false false false false false false true false");
    });

  });


}