import 'package:financialweb/models/conta.dart';
import 'package:financialweb/models/participante.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/atividade.dart';

class AtividadeRepository {
  static List<Atividade> atividades = [
    Atividade(name: 'teste', participantes: [
      Participante(name: 'Participante 1'),
      Participante(name: 'Participante 2'),
      Participante(name: 'Participante 3'),
      Participante(name: 'Participante 4'),
      Participante(name: 'Participante 5'),
      Participante(name: 'Participante 6'),
    ], contas: [
      Conta(
          name: 'Combustível',
          preco: 250,
          payedBy: Participante(name: 'Participante 1')),
      Conta(
          name: 'Cerveja',
          preco: 237,
          payedBy: Participante(name: 'Participante 1')),
      Conta(
          name: 'Aluguel das barraca',
          preco: 327,
          payedBy: Participante( name: 'Participante 1')),
      Conta(
          name: 'Carvão',
          preco: 97,
          payedBy: Participante(name: 'Participante 1')),
      Conta(
          name: 'Picanha 4kg',
          preco: 180,
          payedBy: Participante( name: 'Participante 1')),
      Conta(
          name: 'Pão de alho',
          preco: 68,
          payedBy: Participante(name: 'Participante 1'))
    ])
  ];
  void create(Atividade atividade) {
    dynamic atividadeBox = Hive.box<Atividade>('atividade');
    atividadeBox.add(atividade);
  }

   List<Atividade> all() {
     return (Hive.box<Atividade>('atividade')).values.toList();
   }
    getListenable() {
     return (Hive.box<Atividade>('atividade')).listenable();
   }
}
