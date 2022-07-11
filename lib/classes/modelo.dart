import 'dart:async';

import 'funcao.dart';

class Modelo {
  static String nome = "";
  static List<Object> blocoInicial = <Object>[];
  static List<Object> blocoDeExecucao = <Object>[];
  static List<Object> blocoFinal = <Object>[];
  static List<Funcao> funcoes = <Funcao>[];

  static adicionarNoBlocoInicial({required Object objeto}) {
    blocoInicial.add(objeto);

    EstadoDoModelo.atualizarBlocoInicial(blocoInicial);
  }

  static removerDoBlocoInicial({required int indice}) {
    blocoInicial.removeAt(indice);

    EstadoDoModelo.atualizarBlocoInicial(blocoInicial);
  }

  static adicionarNoBlocoDeExecucao({required Object objeto}) {
    blocoDeExecucao.add(objeto);

    EstadoDoModelo.atualizarBlocoDeExecucao(blocoDeExecucao);
  }

  static removerDoBlocoDeExecucao({required int indice}) {
    blocoDeExecucao.removeAt(indice);

    EstadoDoModelo.atualizarBlocoDeExecucao(blocoDeExecucao);
  }

  static adicionarNoBlocoFinal({required Object objeto}) {
    blocoFinal.add(objeto);

    EstadoDoModelo.atualizarBlocoFinal(blocoFinal);
  }

  static removerDoBlocoFinal({required int indice}) {
    blocoFinal.removeAt(indice);

    EstadoDoModelo.atualizarBlocoFinal(blocoFinal);
  }

  static adicionarFuncao({
    required String nome,
    required String descricao,
    required bool lacoDeRepeticao,
    required String tempoDeRepeticao,
  }) {
    Funcao funcao = Funcao(
      nome,
      descricao,
      lacoDeRepeticao,
      double.tryParse(tempoDeRepeticao) ?? 0,
    );
    funcoes.add(funcao);

    EstadoDoModelo.atualizarFuncoes(funcoes);
  }

  static removerFuncao({required int indice}) {
    funcoes.removeAt(indice);

    EstadoDoModelo.atualizarFuncoes(funcoes);
  }
}

class EstadoDoModelo {
  static StreamController<List<Funcao>> controladorDeFuncoes =
      StreamController();
  static Stream<List<Funcao>> estadoDeFuncoes =
      controladorDeFuncoes.stream.asBroadcastStream();
  static StreamController<List<Object>> controladorDoBlocoInicial =
      StreamController();
  static Stream<List<Object>> estadoDoBlocoInicial =
      controladorDoBlocoInicial.stream.asBroadcastStream();
  static StreamController<List<Object>> controladorDoBlocoDeExecucao =
      StreamController();
  static Stream<List<Object>> estadoDoBlocoDeExecucao =
      controladorDoBlocoDeExecucao.stream.asBroadcastStream();
  static StreamController<List<Object>> controladorDoBlocoFinal =
      StreamController();
  static Stream<List<Object>> estadoDoBlocoFinal =
      controladorDoBlocoFinal.stream.asBroadcastStream();

  static atualizarFuncoes(List<Funcao> funcoes) {
    controladorDeFuncoes.sink.add(funcoes);
  }

  static atualizarBlocoInicial(List<Object> objetos) {
    controladorDoBlocoInicial.sink.add(objetos);
  }

  static atualizarBlocoDeExecucao(List<Object> objetos) {
    controladorDoBlocoDeExecucao.sink.add(objetos);
  }

  static atualizarBlocoFinal(List<Object> objetos) {
    controladorDoBlocoFinal.sink.add(objetos);
  }
}
