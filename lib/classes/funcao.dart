import 'dart:async';

class Funcao {
  String nome = "", descricao = "";
  bool lacoDeRepeticao = false;
  double tempoDeRepeticao = 0;
  List<Object> funcoes = <Object>[];
  StreamController<List<Object>> controladorDeFuncoes = StreamController();
  late Stream<List<Object>> estadoDeFuncoes;

  Funcao(
    this.nome,
    this.descricao,
    this.lacoDeRepeticao,
    this.tempoDeRepeticao,
  ) {
    estadoDeFuncoes = controladorDeFuncoes.stream.asBroadcastStream();
  }

  void adicionarFuncao({required Object funcao}) {
    funcoes.add(funcao);

    _atualizarFuncoes(funcoes);
  }

  void removerFuncao({required int indice}) {
    funcoes.removeAt(indice);

    _atualizarFuncoes(funcoes);
  }

  void _atualizarFuncoes(List<Object> funcoes) {
    controladorDeFuncoes.sink.add(funcoes);
  }
}
