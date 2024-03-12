import 'package:csv/csv.dart';

/// @author Rodrigo Timóteo
class Aula{
  late String curso;
  late String uc;
  late String turno;
  late String turma;
  late int inscritos;
  late String diaDaSemana;
  late String initTime;
  late String finalTime;
  late String date;
  late String characteristics;
  late String sala;

  /// Construtor do objeto normal
  Aula({
    required this.curso,
    required this.uc,
    required this.turno,
    required this.turma,
    required this.inscritos,
    required this.diaDaSemana,
    required this.initTime,
    required this.finalTime,
    required this.date,
    required this.characteristics,
    required this.sala,
  });

  /// Construtor do objeto através de uma lista dinâmica (Para ser compatível com os dados vindo do csv)
  Aula.fromDynamicList(List<dynamic> list){
    curso = list[0];
    uc = list[1];
    turno = list[2];
    turma = list[3];
    inscritos = list[4];
    diaDaSemana = list[5];
    initTime = list[6];
    finalTime = list[7];
    date = list[8];
    characteristics = list[9];
    sala = list[10].toString();
  }

  /// - [list]: Lista de Listas do tipo dynamic (representando um csv)
  /// returns: Uma lista de aulas através de uma List<List<dynamic>>
  static List<Aula> getAulas(List<List<dynamic>> list){
    List<Aula> returnList = [];
    for (var value in list) {
      returnList.add(Aula.fromDynamicList(value));
    }
    return returnList;
  }
  /// returns: Lista (tipo dinâmico) dos atributos do objeto
  List<dynamic> getPropertiesList(){
    List<dynamic> list = [];
    list.add(curso);
    list.add(uc);
    list.add(turno);
    list.add(turma);
    list.add(inscritos.toString());
    list.add(diaDaSemana);
    list.add(initTime);
    list.add(finalTime);
    list.add(date);
    list.add(characteristics);
    list.add(sala);
    return list;
  }

  /// - [list]: Lista de objetos Aula
  /// returns: String do csv
  static String toCsv(List<Aula> list){
    List<List<dynamic>> toConvert = [];
    toConvert.add(["Curso","Unidade Curricular","Turno","Turma","Inscritos no turno","Dia da semana","Hora início da aula","Hora fim da aula","Data da aula","Características da sala pedida para a aula","Sala atribuída à aula"]);
    for (var value in list) {
      toConvert.add(value.getPropertiesList());
    }
    return ListToCsvConverter(fieldDelimiter: ";").convert(toConvert);
  }

  ///Implementação do método toJson (do Flutter) para poder representar um objeto do tipo Aula para Json.
  Map<String, dynamic> toJson(){
    return {
      "curso" : curso,
      "uc" : uc,
      "turno" : turno,
      "turma" : turma,
      "inscritos" : inscritos,
      "diaDaSemana" : diaDaSemana,
      "initTime" : initTime,
      "finalTime" : finalTime,
      "date" : date,
      "characteristics" : characteristics,
      "sala" : sala,
    };
  }

  @override
  String toString() {
    return this.curso + " " + this.uc + " " + this.turno + " " + this.turma + " " + this.inscritos.toString() + " " + this.diaDaSemana + " " + this.initTime + " " + this.finalTime + " " + this.date + " " + this.characteristics + " " + this.sala;
  }
}