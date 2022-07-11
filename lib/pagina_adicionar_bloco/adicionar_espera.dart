import 'package:flutter/material.dart';
import 'package:simulador/classes/esperar.dart';

import '../classes/modelo.dart';

class AdicionarEspera extends StatefulWidget {
  final String tipo;
  const AdicionarEspera({Key? key, required this.tipo}) : super(key: key);

  @override
  State<AdicionarEspera> createState() => _AdicionarEsperaState();
}

class _AdicionarEsperaState extends State<AdicionarEspera> {
  final TextEditingController controladorTempoDeEspera =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              "Adicionar espera",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              controller: controladorTempoDeEspera,
              autofocus: true,
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
                    switch (widget.tipo) {
                      case "inicio":
                        Modelo.adicionarNoBlocoInicial(
                          objeto: Esperar(
                            tempoDeEspera:
                                int.parse(controladorTempoDeEspera.text),
                          ),
                        );
                        break;
                      case "execucao":
                        Modelo.adicionarNoBlocoDeExecucao(
                          objeto: Esperar(
                            tempoDeEspera:
                                int.parse(controladorTempoDeEspera.text),
                          ),
                        );
                        break;
                      case "final":
                        Modelo.adicionarNoBlocoFinal(
                          objeto: Esperar(
                            tempoDeEspera:
                                int.parse(controladorTempoDeEspera.text),
                          ),
                        );
                        break;
                      default:
                        int indice = int.parse(widget.tipo);

                        Modelo.funcoes[indice].adicionarFuncao(
                          funcao: Esperar(
                            tempoDeEspera:
                                int.parse(controladorTempoDeEspera.text),
                          ),
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
