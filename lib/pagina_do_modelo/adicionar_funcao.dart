import 'package:flutter/material.dart';

import '../classes/modelo.dart';

class AdicionarFuncao extends StatefulWidget {
  const AdicionarFuncao({Key? key}) : super(key: key);

  @override
  State<AdicionarFuncao> createState() => _AdicionarFuncaoState();
}

class _AdicionarFuncaoState extends State<AdicionarFuncao> {
  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorDescricao = TextEditingController();
  final TextEditingController controladorDeTempo = TextEditingController();
  bool lacoDeRepeticao = false;

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
            TextField(
              controller: controladorNome,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Nome",
                hintText: "Coloque o nome da função",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controladorDescricao,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Descrição",
                hintText: "Coloque uma descrição",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: lacoDeRepeticao,
                  onChanged: (valor) {
                    setState(() {
                      lacoDeRepeticao = valor ?? false;
                    });
                  },
                ),
                const Text("Criar laço de repetição"),
              ],
            ),
            lacoDeRepeticao
                ? TextField(
                    controller: controladorDeTempo,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Tempo de repetição",
                      hintText: "Coloque um tempo",
                      border: OutlineInputBorder(),
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Modelo.adicionarFuncao(
                      nome: controladorNome.text,
                      descricao: controladorDescricao.text,
                      lacoDeRepeticao: lacoDeRepeticao,
                      tempoDeRepeticao: controladorDeTempo.text,
                    );
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
