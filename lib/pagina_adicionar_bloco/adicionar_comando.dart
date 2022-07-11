import 'package:flutter/material.dart';
import 'package:simulador/classes/comando.dart';

import '../classes/modelo.dart';

class AdicionarComando extends StatefulWidget {
  final String tipo;
  const AdicionarComando({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  @override
  State<AdicionarComando> createState() => _AdicionarComandoState();
}

class _AdicionarComandoState extends State<AdicionarComando> {
  final TextEditingController controladorCabecalho = TextEditingController();
  final TextEditingController controladorRecurso = TextEditingController();
  final TextEditingController controladorDados = TextEditingController();
  final TextEditingController controladorTempoDeEspera =
      TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controladorTempoDeEspera.text = "2000";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              "Adicionar comando",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              controller: controladorCabecalho,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Cabeçalho",
                hintText: "Coloque um cabeçalho",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controladorRecurso,
              decoration: const InputDecoration(
                labelText: "Recurso",
                hintText: "Coloque o recurso",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controladorDados,
              decoration: const InputDecoration(
                labelText: "Dados",
                hintText: "Coloque os dados necessários",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controladorTempoDeEspera,
              decoration: const InputDecoration(
                labelText: "Tempo de espera",
                hintText: "Coloque um tempo de espera em milisegundos",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Comando comando = Comando(
                      tempoDeEspera: int.parse(controladorTempoDeEspera.text),
                      dados: controladorDados.text,
                      cabecalho: controladorCabecalho.text,
                      recurso: controladorRecurso.text,
                    );

                    switch (widget.tipo) {
                      case "inicio":
                        Modelo.adicionarNoBlocoInicial(
                          objeto: comando,
                        );
                        break;
                      case "execucao":
                        Modelo.adicionarNoBlocoDeExecucao(
                          objeto: comando,
                        );
                        break;
                      case "final":
                        Modelo.adicionarNoBlocoFinal(
                          objeto: comando,
                        );
                        break;
                      default:
                        int indice = int.parse(widget.tipo);

                        Modelo.funcoes[indice].adicionarFuncao(
                          funcao: comando,
                        );
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fechar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
