import '../models/atividade.dart';

class AtividadeService {
  calcularTotais(Atividade atividade) {
    double totalContas = atividade.contas!
        .fold(0.0, (previousValue, conta) => previousValue + conta.preco);
    int totalParticipantes = atividade.participantes!.length;
  }
}
