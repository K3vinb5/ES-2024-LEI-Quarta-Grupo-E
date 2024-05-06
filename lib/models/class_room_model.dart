import 'package:csv/csv.dart';

/// This model represents all data related to a class
class ClassRoomModel {

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
  late String isAmphitheater;

  /// Indicates if the room has tech support for events.
  late String isTechSupportForEvents;

  /// Indicates if the room has attribute Arq1.
  late String isArq1;

  /// Indicates if the room has attribute Arq2.
  late String isArq2;

  /// Indicates if the room has attribute Arq3.
  late String isArq3;

  /// Indicates if the room has attribute Arq4.
  late String isArq4;

  /// Indicates if the room has attribute Arq5.
  late String isArq5;

  /// Indicates if the room has attribute Arq6.
  late String isArq6;

  /// Indicates if the room has attribute Arq9.
  late String isArq9;

  /// Indicates if the room has BYOD (Bring Your Own Device) capability.
  late String isBYOD;

  /// Indicates if the room is suitable for focus groups.
  late String isFocusGroup;

  /// Indicates if the room has a public schedule.
  late String hasPublicSchedule;

  /// Indicates if the room is FACLab1.
  late String isFACLab1;

  /// Indicates if the room is FACLab2.
  late String isFACLab2;

  /// Indicates if the room is BELab.
  late String isBELab;

  /// Indicates if the room is an electronics lab.
  late String isElectronicsLab;

  /// Indicates if the room is a computer lab.
  late String isComputerLab;

  /// Indicates if the room is a journalism lab.
  late String isJournalismLab;

  /// Indicates if the room is NetworkLab1.
  late String isNetworkLab1;

  /// Indicates if the room is NetworkLab2.
  late String isNetworkLab2;

  /// Indicates if the room is a telecommunications lab.
  late String isTelecommunicationsLab;

  /// Indicates if the room is a masters lab.
  late String isMastersRoom;

  /// Indicates if the room is a masters lab plus.
  late String isMastersRoomPlus;

  /// Indicates if the room is a NEE room.
  late String isNEERoom;

  /// Indicates if the room is a Exam room.
  late String isExamRoom;

  /// Indicates if the room is a reunion room.
  late String isReunionRoom;

  /// Indicates if the room is an architecture room.
  late String isArchitectureRoom;

  /// Indicates if the room is a normal room.
  late String isNormalRoom;

  /// Indicates if the room has videoconference gear.
  late String hasVideoconferenceGear;

  /// Indicates if the room is an atrium.
  late String isAtrium;

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
    isAmphitheater = list[5].toString();
    isTechSupportForEvents = list[6].toString();
    isArq1 = list[7].toString();
    isArq2 = list[8].toString();
    isArq3 = list[9].toString();
    isArq4 = list[10].toString();
    isArq5 = list[11].toString();
    isArq6 = list[12].toString();
    isArq9 = list[13].toString();
    isBYOD = list[14].toString();
    isFocusGroup = list[15].toString();
    hasPublicSchedule = list[16].toString();
    isFACLab1 = list[17].toString();
    isFACLab2 = list[18].toString();
    isBELab = list[19].toString();
    isElectronicsLab = list[20].toString();
    isComputerLab = list[21].toString();
    isJournalismLab = list[22].toString();
    isNetworkLab1 = list[23].toString();
    isNetworkLab2 = list[24].toString();
    isTelecommunicationsLab = list[25].toString();
    isMastersRoom = list[26].toString();
    isMastersRoomPlus = list[27].toString();
    isNEERoom = list[28].toString();
    isExamRoom = list[29].toString();
    isReunionRoom = list[30].toString();
    isArchitectureRoom = list[31].toString();
    isNormalRoom = list[32].toString();
    hasVideoconferenceGear = list[33].toString();
    isAtrium = list[34].toString();
  }

  /// Converts a list of lists of dynamic objects (csv representation) into a
  /// list of classrooms
  /// Parameters:
  /// - [list]: List of Lists of dynamic type (csv representation)
  /// Returns:
  /// A list of classrooms converted from the given input
  static List<ClassRoomModel> getClassRooms(List<List<dynamic>> list) {
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
  static String toCsv(List<ClassRoomModel> list) {
    List<List<dynamic>> toConvert = [];
    toConvert.add(
        [
          "Edifício",
          "Nome sala",
          "Capacidade Normal",
          "Capacidade Exame",
          "Nº Características",
          "Anfiteatro aulas",
          "Apoio técnico eventos",
          "Arq 1",
          "Arq 2",
          "Arq 3",
          "Arq 4",
          "Arq 5",
          "Arq 6",
          "Arq 9",
          "BYOD (Bring Your Own Device)",
          "Focus Group",
          "Horário sala visível portal público",
          "Laboratório de Arquitectura de Computadores I",
          "Laboratório de Arquitectura de Computadores II",
          "Laboratório de Bases de Engenharia",
          "Laboratório de Electrónica",
          "Laboratório de Informática",
          "Laboratório de Jornalismo",
          "Laboratório de Redes de Computadores I",
          "Laboratório de Redes de Computadores II",
          "Laboratório de Telecomunicações",
          "Sala Aulas Mestrado",
          "Sala Aulas Mestrado Plus",
          "Sala NEE",
          "Sala Provas",
          "Sala Reunião",
          "Sala de Arquitectura",
          "Sala de Aulas normal",
          "Videoconferência",
          "Átrio"
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
  Map<String, dynamic> toJson() {
    return {
      "edifício": building,
      "nomeSala": roomName,
      "capacidadeNormal": normalCapacity,
      "capacidadeExame": examCapacity,
      "numCaracteristicas": characteristicsNumber,
      "anfiteatroAulas": isAmphitheater,
      "apoioTecnicoEventos": isTechSupportForEvents,
      "arq1": isArq1,
      "arq2": isArq2,
      "arq3": isArq3,
      "arq4": isArq4,
      "arq5": isArq5,
      "arq6": isArq6,
      "arq9": isArq9,
      "byod": isBYOD,
      "focusGroup": isFocusGroup,
      "horarioSalaVisivelPortalPublico": hasPublicSchedule,
      "laboratorioArquitectureDeComputadoresI": isFACLab1,
      "laboratorioArquitectureDeComputadoresII": isFACLab2,
      "laboratorioBasesDeEngenharia": isBELab,
      "laboratorioEletronica": isElectronicsLab,
      "laboratorioInformatica": isComputerLab,
      "laboratorioJornalismo": isJournalismLab,
      "laboratorioRedesDeComputadoresI": isNetworkLab1,
      "laboratorioRedesDeComputadoresII": isNetworkLab2,
      "laboratorioTelecomunicacoes": isTelecommunicationsLab,
      "salaAulasMestrado": isMastersRoom,
      "salaAulasMestradoPlus": isMastersRoomPlus,
      "salaNEE": isNEERoom,
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
  List<dynamic> getPropertiesList() {
    List<dynamic> list = [];
    list.add(building);
    list.add(roomName);
    list.add(normalCapacity);
    list.add(examCapacity);
    list.add(characteristicsNumber);
    list.add(isAmphitheater.toString());
    list.add(isTechSupportForEvents.toString());
    list.add(isArq1.toString());
    list.add(isArq2.toString());
    list.add(isArq3.toString());
    list.add(isArq4.toString());
    list.add(isArq5.toString());
    list.add(isArq6.toString());
    list.add(isArq9.toString());
    list.add(isBYOD.toString());
    list.add(isFocusGroup.toString());
    list.add(hasPublicSchedule.toString());
    list.add(isFACLab1.toString());
    list.add(isFACLab2.toString());
    list.add(isBELab.toString());
    list.add(isElectronicsLab.toString());
    list.add(isComputerLab.toString());
    list.add(isJournalismLab.toString());
    list.add(isNetworkLab1.toString());
    list.add(isNetworkLab2.toString());
    list.add(isTelecommunicationsLab.toString());
    list.add(isMastersRoom.toString());
    list.add(isMastersRoomPlus.toString());
    list.add(isNEERoom.toString());
    list.add(isExamRoom.toString());
    list.add(isReunionRoom.toString());
    list.add(isArchitectureRoom.toString());
    list.add(isNormalRoom.toString());
    list.add(hasVideoconferenceGear.toString());
    list.add(isAtrium.toString());

    return list;
  }

  void setProperty(int index, String value) {
    switch (index) {
      case 0:
        building = value;
        break;
      case 1:
        roomName = value;
        break;
      case 2:
        normalCapacity = value;
        break;
      case 3:
        examCapacity = value;
        break;
      case 4:
        characteristicsNumber = value;
        break;
      case 5:
        isAmphitheater = value.isNotEmpty ? "X" : "";
        break;
      case 6:
        isTechSupportForEvents = value.isNotEmpty ? "X" : "";
        break;
      case 7:
        isArq1 = value.isNotEmpty ? "X" : "";
        break;
      case 8:
        isArq2 = value.isNotEmpty ? "X" : "";
        break;
      case 9:
        isArq3 = value.isNotEmpty ? "X" : "";
        break;
      case 10:
        isArq4 = value.isNotEmpty ? "X" : "";
        break;
      case 11:
        isArq5 = value.isNotEmpty ? "X" : "";
        break;
      case 12:
        isArq6 = value.isNotEmpty ? "X" : "";
        break;
      case 13:
        isArq9 = value.isNotEmpty ? "X" : "";
        break;
      case 14:
        isBYOD = value.isNotEmpty ? "X" : "";
        break;
      case 15:
        isFocusGroup = value.isNotEmpty ? "X" : "";
        break;
      case 16:
        hasPublicSchedule = value.isNotEmpty ? "X" : "";
        break;
      case 17:
        isFACLab1 = value.isNotEmpty ? "X" : "";
        break;
      case 18:
        isFACLab2 = value.isNotEmpty ? "X" : "";
      case 19:
        isBELab = value.isNotEmpty ? "X" : "";
        break;
      case 20:
        isElectronicsLab = value.isNotEmpty ? "X" : "";
        break;
      case 21:
        isComputerLab = value.isNotEmpty ? "X" : "";
        break;
      case 22:
        isJournalismLab = value.isNotEmpty ? "X" : "";
        break;
      case 23:
        isNetworkLab1 = value.isNotEmpty ? "X" : "";
        break;
      case 24:
        isNetworkLab2 = value.isNotEmpty ? "X" : "";
        break;
      case 25:
        isTelecommunicationsLab = value.isNotEmpty ? "X" : "";
        break;
      case 26:
        isMastersRoom = value.isNotEmpty ? "X" : "";
        break;
      case 27:
        isMastersRoomPlus = value.isNotEmpty ? "X" : "";
        break;
      case 28:
        isNEERoom = value.isNotEmpty ? "X" : "";
        break;
      case 29:
        isExamRoom = value.isNotEmpty ? "X" : "";
        break;
      case 30:
        isReunionRoom = value.isNotEmpty ? "X" : "";
        break;
      case 31:
        isArchitectureRoom = value.isNotEmpty ? "X" : "";
        break;
      case 32:
        isNormalRoom = value.isNotEmpty ? "X" : "";
        break;
      case 33:
        hasVideoconferenceGear = value.isNotEmpty ? "X" : "";
        break;
      case 34:
        isAtrium = value.isNotEmpty ? "X" : "";
        break;
    }
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