extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String formatarNomeDoModelo(String nome) {
  List<String> nomeSeparado = nome.split(" ");
  String novoNome = nomeSeparado[0].capitalize();

  if (nomeSeparado.length > 1) {
    for (int i = 1; i < nomeSeparado.length; i++) {
      novoNome += nomeSeparado[i].capitalize();
    }
  }

  return novoNome;
}

String formatarNomeDaFuncao(String nome) {
  List<String> nomeSeparado = nome.split(" ");
  String novoNome = nomeSeparado[0].toLowerCase();

  if (nomeSeparado.length > 1) {
    for (int i = 1; i < nomeSeparado.length; i++) {
      novoNome += nomeSeparado[i].capitalize();
    }
  }

  return novoNome;
}
