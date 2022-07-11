import 'package:simulador/backend/formatar_nomes.dart';
import 'package:simulador/classes/comando.dart';
import 'package:simulador/classes/esperar.dart';
import 'package:simulador/classes/funcao.dart';

import '../classes/modelo.dart';

String inicioDaClasse = "class {modelo} extends Modelo {";
String finalDaClasse = "}";

String inicioDoIniciar = """@override
Future<NormalizacaoDeResposta> iniciar() async {
NormalizacaoDeResposta respostaNormalizada = NormalizacaoDeResposta();
RespostaBluetooth resposta = RespostaBluetooth();
""";
String finalDoIniciar = """return respostaNormalizada;
}
""";

String inicioDoExecutar = """@override
Future<NormalizacaoDeResposta> executar() async {
NormalizacaoDeResposta respostaNormalizada = NormalizacaoDeResposta();
RespostaBluetooth resposta = RespostaBluetooth();
""";
String finalDoExecutar = """return respostaNormalizada;
}
""";

String inicioDoFinalizar = """@override
Future<NormalizacaoDeResposta> finalizar() async {
NormalizacaoDeResposta resposta = NormalizacaoDeResposta();
RespostaBluetooth resposta = RespostaBluetooth();
""";
String finalDoFinalizar = """return respostaNormalizada;
}
""";

String inicioDaFuncao = """Future<NormalizacaoDeResposta> {funcao}() async {
NormalizacaoDeResposta respostaNormalizada = NormalizacaoDeResposta();
RespostaBluetooth resposta = RespostaBluetooth();
""";
String finalDaFuncao = """return respostaNormalizada;
}
""";
String executarFuncao = "respostaNormalizada = await {funcao}();";

String comando = """resposta = await comunicacaoBluetooth.transmitir(
cabecalho: "{cabecalho}", recurso: "{recurso}", dados: "{dados}", 
tempoDeEspera: {tempo}, foraDoFluxo: {fora},);
""";
String normalizarComando = "respostaNormalizada = normalizar(resposta);";

String verificarErro =
    "if(respostaNormalizada.possuiErro()) return respostaNormalizada;";

String esperar = "await esperar(tempoDeEspera: {tempo}, foraDoFluxo: {fora});";

String inicioDoLaco = """bool respostaDoLaco = await super.laco(() async {
""";
String finalDoLaco = """return respostaNormalizada.possuiErro();
}, tempoDeEspera: {tempo},);
""";

String finalDoLacoEFuncao =
    """if (!respostaDoLaco) return NormalizacaoDeResposta(codigoDeRastreio: "01");
return respostaNormalizada;
}
""";

String comentario = "// {comentario}";

String gerarArquivo() {
  String resultado = "";
  String nomeDoModelo = formatarNomeDoModelo(Modelo.nome);
  resultado += inicioDaClasse.replaceAll("{modelo}", nomeDoModelo);

  resultado += "\n";
  resultado += inicioDoIniciar;
  resultado += "\n";
  for (Object objeto in Modelo.blocoInicial) {
    switch (objeto.runtimeType) {
      case Funcao:
        Funcao funcao = objeto as Funcao;
        String nomeDaFuncao = formatarNomeDaFuncao(funcao.nome);
        resultado += executarFuncao.replaceAll("{funcao}", nomeDaFuncao);
        resultado += "\n";
        resultado += verificarErro;
        break;
      case Esperar:
        Esperar esperarObjeto = objeto as Esperar;
        resultado += esperar
            .replaceAll(
              "{tempo}",
              esperarObjeto.tempoDeEspera.toString(),
            )
            .replaceAll("{fora}", false.toString());
        break;
      case Comando:
        Comando comandoObjeto = objeto as Comando;
        resultado += comando
            .replaceAll("{cabecalho}", comandoObjeto.cabecalho)
            .replaceAll("{recurso}", comandoObjeto.recurso)
            .replaceAll("{dados}", comandoObjeto.dados)
            .replaceAll("{tempo}", comandoObjeto.tempoDeEspera.toString())
            .replaceAll("{fora}", false.toString());
        resultado += normalizarComando;
        resultado += "\n";
        resultado += verificarErro;
        break;
    }
    resultado += "\n\n";
  }
  resultado += finalDoIniciar;
  resultado += "\n";

  resultado += inicioDoExecutar;
  resultado += "\n";
  for (Object objeto in Modelo.blocoDeExecucao) {
    switch (objeto.runtimeType) {
      case Funcao:
        Funcao funcao = objeto as Funcao;
        String nomeDaFuncao = formatarNomeDaFuncao(funcao.nome);
        resultado += executarFuncao.replaceAll("{funcao}", nomeDaFuncao);
        resultado += "\n";
        resultado += verificarErro;
        break;
      case Esperar:
        Esperar esperarObjeto = objeto as Esperar;
        resultado += esperar
            .replaceAll(
              "{tempo}",
              esperarObjeto.tempoDeEspera.toString(),
            )
            .replaceAll("{fora}", false.toString());
        ;
        break;
      case Comando:
        Comando comandoObjeto = objeto as Comando;
        resultado += comando
            .replaceAll("{cabecalho}", comandoObjeto.cabecalho)
            .replaceAll("{recurso}", comandoObjeto.recurso)
            .replaceAll("{dados}", comandoObjeto.dados)
            .replaceAll("{tempo}", comandoObjeto.tempoDeEspera.toString())
            .replaceAll("{fora}", false.toString());
        resultado += normalizarComando;
        resultado += "\n";
        resultado += verificarErro;
        break;
    }
    resultado += "\n\n";
  }
  resultado += finalDoExecutar;
  resultado += "\n";

  resultado += inicioDoFinalizar;
  resultado += "\n";
  for (Object objeto in Modelo.blocoFinal) {
    switch (objeto.runtimeType) {
      case Funcao:
        Funcao funcao = objeto as Funcao;
        String nomeDaFuncao = formatarNomeDaFuncao(funcao.nome);
        resultado += executarFuncao.replaceAll("{funcao}", nomeDaFuncao);
        resultado += "\n";
        resultado += verificarErro;
        break;
      case Esperar:
        Esperar esperarObjeto = objeto as Esperar;
        resultado += esperar
            .replaceAll(
              "{tempo}",
              esperarObjeto.tempoDeEspera.toString(),
            )
            .replaceAll("{fora}", true.toString());
        ;
        break;
      case Comando:
        Comando comandoObjeto = objeto as Comando;
        resultado += comando
            .replaceAll("{cabecalho}", comandoObjeto.cabecalho)
            .replaceAll("{recurso}", comandoObjeto.recurso)
            .replaceAll("{dados}", comandoObjeto.dados)
            .replaceAll("{tempo}", comandoObjeto.tempoDeEspera.toString())
            .replaceAll("{fora}", true.toString());
        resultado += normalizarComando;
        resultado += "\n";
        resultado += verificarErro;
        break;
    }
    resultado += "\n\n";
  }
  resultado += finalDoFinalizar;
  resultado += "\n";

  for (Funcao funcao in Modelo.funcoes) {
    String nomeDaFuncao = formatarNomeDaFuncao(funcao.nome);

    resultado += "\n";
    resultado += comentario.replaceAll("{comentario}", funcao.descricao);
    resultado += "\n";
    resultado += inicioDaFuncao.replaceAll("{funcao}", nomeDaFuncao);
    resultado += "\n";

    if (funcao.lacoDeRepeticao) resultado += inicioDoLaco;

    for (Object objeto in funcao.funcoes) {
      switch (objeto.runtimeType) {
        case Funcao:
          Funcao funcao = objeto as Funcao;
          String nomeDaFuncao = formatarNomeDaFuncao(funcao.nome);
          resultado += executarFuncao.replaceAll("{funcao}", nomeDaFuncao);
          resultado += "\n";
          resultado += verificarErro;
          break;
        case Esperar:
          Esperar esperarObjeto = objeto as Esperar;
          resultado += esperar
              .replaceAll(
                "{tempo}",
                esperarObjeto.tempoDeEspera.toString(),
              )
              .replaceAll("{fora}", true.toString());
          break;
        case Comando:
          Comando comandoObjeto = objeto as Comando;
          resultado += comando
              .replaceAll("{cabecalho}", comandoObjeto.cabecalho)
              .replaceAll("{recurso}", comandoObjeto.recurso)
              .replaceAll("{dados}", comandoObjeto.dados)
              .replaceAll("{tempo}", comandoObjeto.tempoDeEspera.toString())
              .replaceAll("{fora}", true.toString());
          resultado += normalizarComando;
          resultado += "\n";
          if (!funcao.lacoDeRepeticao) resultado += verificarErro;
          break;
      }
      resultado += "\n\n";
    }

    if (funcao.lacoDeRepeticao) {
      resultado += finalDoLaco.replaceAll(
        "{tempo}",
        funcao.tempoDeRepeticao.toString(),
      );
      resultado += finalDoLacoEFuncao;
    } else {
      resultado += finalDaFuncao;
    }
    resultado += "\n";
  }

  resultado += finalDaClasse;
  return resultado;
}
