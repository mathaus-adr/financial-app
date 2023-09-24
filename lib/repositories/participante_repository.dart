import 'package:financialweb/models/participante.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ParticipanteRepository {
  ParticipanteRepository();

  Future<Participante> create(String name) async {
    dynamic atividadeBox = Hive.box<Participante>('participante');
    Participante participante = Participante(name: name);
    atividadeBox.add(participante);
    return participante;
  }

  Future<List<Participante>> all() async {
    return (await Hive.openBox<Participante>('participante')).values.toList();
  }
  
  getListenable() {
    return (Hive.box<Participante>('participante')).listenable();
  }
}
