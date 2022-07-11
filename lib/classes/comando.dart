class Comando {
  String cabecalho, recurso, dados;
  int tempoDeEspera;
  bool guardarResposta;

  Comando({
    required this.cabecalho,
    required this.recurso,
    required this.dados,
    required this.tempoDeEspera,
    this.guardarResposta = true,
  });
}
