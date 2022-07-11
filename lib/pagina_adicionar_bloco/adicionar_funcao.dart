import 'package:flutter/material.dart';
import 'package:simulador/classes/modelo.dart';

class AdicionarFuncao extends StatelessWidget {
  final String tipo;
  const AdicionarFuncao({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              "Adicionar função",
              style: Theme.of(context).textTheme.headline6,
            ),
            ...List.generate(
              Modelo.funcoes.length,
              (index) => ListTile(
                title: Text(Modelo.funcoes[index].nome),
                subtitle: Text(Modelo.funcoes[index].descricao),
                onTap: () {
                  switch (tipo) {
                    case "inicio":
                      Modelo.adicionarNoBlocoInicial(
                        objeto: Modelo.funcoes[index],
                      );
                      break;
                    case "execucao":
                      Modelo.adicionarNoBlocoDeExecucao(
                        objeto: Modelo.funcoes[index],
                      );
                      break;
                    case "final":
                      Modelo.adicionarNoBlocoFinal(
                        objeto: Modelo.funcoes[index],
                      );
                      break;
                    default:
                      int indice = int.parse(tipo);

                      Modelo.funcoes[indice].adicionarFuncao(
                        funcao: Modelo.funcoes[index],
                      );
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
