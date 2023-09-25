import 'package:financialweb/models/atividade.dart';
import 'package:financialweb/models/participante.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'apps/financial_web.dart';
import 'models/conta.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AtividadeAdapter());
  Hive.registerAdapter(ContaAdapter());
  Hive.registerAdapter(ParticipanteAdapter());
  (await Hive.openBox<Atividade>('atividade')).clear();
  (await Hive.openBox<Conta>('conta')).clear();
  (await Hive.openBox<Participante>('participante')).clear();

  runApp(const FinancialApp());
}
