import 'package:flutter/material.dart';
import 'package:simulador/classes/modelo.dart';
import 'package:simulador/pagina_do_modelo/pagina_do_modelo.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final TextEditingController controladorNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: controladorNome,
                decoration: const InputDecoration(
                  labelText: "Nome do modelo",
                  hintText: "Digite o nome do modelo",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FloatingActionButton.large(
                  onPressed: () async {
                    if (controladorNome.text.trim().isEmpty) {
                      return await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Atenção"),
                            content: const SingleChildScrollView(
                              child: Text("Adicione um nome para o modelo"),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Fechar"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    Modelo.nome = controladorNome.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaginaDoModelo(
                          nome: controladorNome.text,
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
