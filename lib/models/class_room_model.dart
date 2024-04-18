import 'package:csv/csv.dart';

/// This model represents all data related to a class
class ClassRoomModel {

  /// Converts a string representation of boolean ("X" for true) to a boolean value.
  ///
  /// Returns:
  /// true if the input string is "X"; otherwise, returns false.
  bool convertStringToBool(String string) {
    return string == "X";
  }

  /// The name of the building where the room is located.
  late String building;

  /// The name of the room.
  late String roomName;

  /// The normal capacity of the room.
  late String normalCapacity;

  /// The exam capacity of the room.
  late String examCapacity;

  /// The number of characteristics of the room.
  late String characteristicsNumber;

  /// Indicates if the room is an amphitheater.
  late bool isAmphitheater;

  /// Indicates if the room has tech support for events.
  late bool isTechSupportForEvents;

  /// Indicates if the room has attribute Arq1.
  late bool isArq1;

  /// Indicates if the room has attribute Arq2.
  late bool isArq2;

  /// Indicates if the room has attribute Arq3.
  late bool isArq3;

  /// Indicates if the room has attribute Arq4.
  late bool isArq4;

  /// Indicates if the room has attribute Arq5.
  late bool isArq5;

  /// Indicates if the room has attribute Arq6.
  late bool isArq6;

  /// Indicates if the room has attribute Arq9.
  late bool isArq9;

  /// Indicates if the room has BYOD (Bring Your Own Device) capability.
  late bool isBYOD;

  /// Indicates if the room is suitable for focus groups.
  late bool isFocusGroup;

  /// Indicates if the room has a public schedule.
  late bool hasPublicSchedule;

  /// Indicates if the room is FACLab1.
  late bool isFACLab1;

  /// Indicates if the room is FACLab2.
  late bool isFACLab2;

  /// Indicates if the room is BELab.
  late bool isBELab;

  /// Indicates if the room is an electronics lab.
  late bool isElectronicsLab;

  /// Indicates if the room is a computer lab.
  late bool isComputerLab;

  /// Indicates if the room is a journalism lab.
  late bool isJournalismLab;

  /// Indicates if the room is NetworkLab1.
  late bool isNetworkLab1;

  /// Indicates if the room is NetworkLab2.
  late bool isNetworkLab2;

  /// Indicates if the room is a telecommunications lab.
  late bool isTelecommunicationsLab;

  /// Indicates if the room is a masters lab.
  late bool isMastersRoom;

  /// Indicates if the room is a masters lab plus.
  late bool isMastersRoomPlus;

  /// Indicates if the room is a NEE room.
  late bool isNEERoom;

  /// Indicates if the room is a Exam room.
  late bool isExamRoom;

  /// Indicates if the room is a reunion room.
  late bool isReunionRoom;

  /// Indicates if the room is an architecture room.
  late bool isArchitectureRoom;

  /// Indicates if the room is a normal room.
  late bool isNormalRoom;

  /// Indicates if the room has videoconference gear.
  late bool hasVideoconferenceGear;

  /// Indicates if the room is an atrium.
  late bool isAtrium;

  /// ClassRoomModel constructor
  ClassRoomModel({
    required this.building,
    required this.roomName,
    required this.normalCapacity,
    required this.examCapacity,
    required this.characteristicsNumber,
    required this.isAmphitheater,
    required this.isTechSupportForEvents,
    required this.isArq1,
    required this.isArq2,
    required this.isArq3,
    required this.isArq4,
    required this.isArq5,
    required this.isArq6,
    required this.isArq9,
    required this.isBYOD,
    required this.isFocusGroup,
    required this.hasPublicSchedule,
    required this.isFACLab1,
    required this.isFACLab2,
    required this.isBELab,
    required this.isElectronicsLab,
    required this.isComputerLab,
    required this.isJournalismLab,
    required this.isNetworkLab1,
    required this.isNetworkLab2,
    required this.isTelecommunicationsLab,
    required this.isMastersRoom,
    required this.isMastersRoomPlus,
    required this.isNEERoom,
    required this.isExamRoom,
    required this.isReunionRoom,
    required this.isArchitectureRoom,
    required this.isNormalRoom,
    required this.hasVideoconferenceGear,
    required this.isAtrium
  });

  /// Constructor from a dynamic list (this is used in order to make compatibility
  /// with the csv format provided)
  /// Parameters:
  /// - [list]: List of dynamic type that contains the information needed to
  /// construct a new ClassRoomModel
  /// Returns:
  /// A ClassRoomModel with the given information
  ClassRoomModel.fromDynamicList(List<dynamic> list){
    building = list[0].toString();
    roomName = list[1].toString();
    normalCapacity = list[2].toString();
    examCapacity = list[3].toString();
    characteristicsNumber = list[4].toString();
    isAmphitheater = convertStringToBool(list[5]);
    isTechSupportForEvents = convertStringToBool(list[6]);
    isArq1 = convertStringToBool(list[7]);
    isArq2 = convertStringToBool(list[8]);
    isArq3 = convertStringToBool(list[9]);
    isArq4 = convertStringToBool(list[10]);
    isArq5 = convertStringToBool(list[11]);
    isArq6 = convertStringToBool(list[12]);
    isArq9 = convertStringToBool(list[13]);
    isBYOD = convertStringToBool(list[14]);
    isFocusGroup = convertStringToBool(list[15]);
    hasPublicSchedule = convertStringToBool(list[16]);
    isFACLab1 = convertStringToBool(list[17]);
    isFACLab2 = convertStringToBool(list[18]);
    isBELab = convertStringToBool(list[19]);
    isElectronicsLab = convertStringToBool(list[20]);
    isComputerLab = convertStringToBool(list[21]);
    isJournalismLab = convertStringToBool(list[22]);
    isNetworkLab1 = convertStringToBool(list[23]);
    isNetworkLab2 = convertStringToBool(list[24]);
    isTelecommunicationsLab = convertStringToBool(list[25]);
    isMastersRoom = convertStringToBool(list[26]);
    isMastersRoomPlus = convertStringToBool(list[27]);
    isNEERoom = convertStringToBool(list[28]);
    isExamRoom = convertStringToBool(list[29]);
    isReunionRoom = convertStringToBool(list[30]);
    isArchitectureRoom = convertStringToBool(list[31]);
    isNormalRoom = convertStringToBool(list[32]);
    hasVideoconferenceGear = convertStringToBool(list[33]);
    isAtrium = convertStringToBool(list[34]);
  }

  /// Converts a list of lists of dynamic objects (csv representation) into a
  /// list of classrooms
  /// Parameters:
  /// - [list]: List of Lists of dynamic type (csv representation)
  /// Returns:
  /// A list of classrooms converted from the given input
  static List<ClassRoomModel> getClassRooms(List<List<dynamic>> list){
    List<ClassRoomModel> returnList = [];

    for (var value in list) {
      returnList.add(ClassRoomModel.fromDynamicList(value));
    }

    return returnList;
  }

  /// Converts a list of classrooms into a csv string
  /// Parameters:
  /// - [list]: List of Classes
  /// Returns:
  /// A csv string with the class parameters
  static String toCsv(List<ClassRoomModel> list){
    List<List<dynamic>> toConvert = [];
    toConvert.add(["Edifício","Nome sala","Capacidade Normal","Capacidade Exame",
      "Nº Características", "Anfiteatro aulas", "Apoio técnico eventos", "Arq 1",
      "Arq 2","Arq 3","Arq 4","Arq 5", "Arq 6", "Arq 9", "BYOD (Bring Your Own Device)",
      "Focus Group","Horário sala visível portal público", "Laboratório de Arquitectura de Computadores I",
      "Laboratório de Arquitectura de Computadores II", "Laboratório de Bases de Engenharia",
      "Laboratório de Electrónica", "Laboratório de Informática", "Laboratório de Jornalismo",
      "Laboratório de Redes de Computadores I", "Laboratório de Redes de Computadores II",
      "Laboratório de Telecomunicações", "Sala Aulas Mestrado", "Sala Aulas Mestrado Plus",
      "Sala NEE", "Sala Provas", "Sala Reunião", "Sala de Arquitectura", "Sala de Aulas normal",
      "videoconferência", "Átrio"
    ]);

    for (var value in list) {
      toConvert.add(value.getPropertiesList());
    }

    return const ListToCsvConverter(fieldDelimiter: ";").convert(toConvert);
  }

  /// Implementation of default method toJson in order to represent an object of
  /// the ClassRoomModel type and its attributes
  /// Returns:
  /// A JSON Map that for any given key as the attributed value
  Map<String, dynamic> toJson(){
    return {
      "edifício" : building,
      "nomeSala" : roomName,
      "capacidadeNormal" : normalCapacity,
      "capacidadeExame" : examCapacity,
      "numCaracteristicas" : characteristicsNumber,
      "anfiteatroAulas" : isAmphitheater,
      "apoioTecnicoEventos" : isTechSupportForEvents,
      "arq1" : isArq1,
      "arq2" : isArq2,
      "arq3" : isArq3,
      "arq4" : isArq4,
      "arq5" : isArq5,
      "arq6" : isArq6,
      "arq9" : isArq9,
      "byod" : isBYOD,
      "focusGroup" : isFocusGroup,
      "horarioSalaVisivelPortalPublico" : hasPublicSchedule,
      "laboratorioArquitectureDeComputadoresI" : isFACLab1,
      "laboratorioArquitectureDeComputadoresII" : isFACLab2,
      "laboratorioBasesDeEngenharia" : isBELab,
      "laboratorioEletronica" : isElectronicsLab,
      "laboratorioInformatica" : isComputerLab,
      "laboratorioJornalismo" : isJournalismLab,
      "laboratorioRedesDeComputadoresI" : isNetworkLab1,
      "laboratorioRedesDeComputadoresII" : isNetworkLab2,
      "laboratorioTelecomunicacoes" : isTelecommunicationsLab,
      "salaAulasMestrado" : isMastersRoom,
      "salaAulasMestradoPlus" : isMastersRoomPlus,
      "salaNEE" : isNEERoom,
      "salaProvas": isExamRoom,
      "salaReuniao": isReunionRoom,
      "salaArquitetura": isArchitectureRoom,
      "salaAulasNormal": isNormalRoom,
      "videoconferencia": hasVideoconferenceGear,
      "atrio": isAtrium
    };
  }

  /// Creates a dynamic type list with all the properties from the classroom model
  /// Returns:
  /// A List (dynamic typing) of the class attributes
  List<dynamic> getPropertiesList(){
    List<dynamic> list = [];
    list.add(building);
    list.add(roomName);
    list.add(normalCapacity);
    list.add(examCapacity);
    list.add(characteristicsNumber);
    list.add(isAmphitheater);
    list.add(isTechSupportForEvents);
    list.add(isArq1);
    list.add(isArq2);
    list.add(isArq3);
    list.add(isArq4);
    list.add(isArq5);
    list.add(isArq6);
    list.add(isArq9);
    list.add(isBYOD);
    list.add(isFocusGroup);
    list.add(hasPublicSchedule);
    list.add(isFACLab1);
    list.add(isFACLab2);
    list.add(isBELab);
    list.add(isElectronicsLab);
    list.add(isComputerLab);
    list.add(isJournalismLab);
    list.add(isNetworkLab1);
    list.add(isNetworkLab2);
    list.add(isTelecommunicationsLab);
    list.add(isMastersRoom);
    list.add(isMastersRoomPlus);
    list.add(isNEERoom);
    list.add(isExamRoom);
    list.add(isReunionRoom);
    list.add(isArchitectureRoom);
    list.add(isNormalRoom);
    list.add(hasVideoconferenceGear);
    list.add(isAtrium);

    return list;
  }

  /// Creates a string with all the classes parameters separated by spaces
  /// (debug and readability purposes)
  @override
  String toString() {
    return "$building $roomName $normalCapacity $characteristicsNumber $isAmphitheater "
        "$isTechSupportForEvents $isArq1 $isArq2 $isArq3 $isArq4 $isArq5 $isArq6 "
        "$isArq9 $isBYOD $isFocusGroup $hasPublicSchedule $isFACLab1 $isFACLab2 "
        "$isBELab $isElectronicsLab $isComputerLab $isJournalismLab $isNetworkLab1 "
        "$isNetworkLab2 $isTelecommunicationsLab $isMastersRoom $isMastersRoomPlus "
        "$isNEERoom $isExamRoom $isReunionRoom $isArchitectureRoom $isNormalRoom "
        "$hasVideoconferenceGear";
  }

}