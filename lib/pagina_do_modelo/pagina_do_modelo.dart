import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador/backend/salvar.dart';

import '../classes/funcao.dart';
import '../classes/modelo.dart';
import '../pagina_adicionar_bloco/pagina_adicionar_bloco.dart';
import '../pagina_do_modelo/adicionar_funcao.dart';

class PaginaDoModelo extends StatefulWidget {
  final String nome;
  const PaginaDoModelo({Key? key, required this.nome}) : super(key: key);

  @override
  State<PaginaDoModelo> createState() => _PaginaDoModeloState();
}

class _PaginaDoModeloState extends State<PaginaDoModelo> {
  List<Funcao> funcoes = <Funcao>[];
  late StreamSubscription inscricaoDasFuncoes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        funcoes = Modelo.funcoes;
      });

      inscricaoDasFuncoes = EstadoDoModelo.estadoDeFuncoes.listen((event) {
        setState(() {
          funcoes = event;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    inscricaoDasFuncoes.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina do modelo: ${widget.nome}"),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Row(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 30,
                          ),
                          Text("Aguarde, processando arquivo..."),
                        ],
                      ),
                    ),
                  );
                },
              );
              try {
                String resultado = gerarArquivo();

                Clipboard.setData(ClipboardData(text: resultado));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Arquivo copiado para a área de transferência"),
                  ),
                );
              } catch (e, stack) {
                Navigator.pop(context);

                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Atenção"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Fechar"),
                        ),
                      ],
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectableText("Erro: ${e.toString()}\n\n$stack"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const AdicionarFuncao();
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                title: const Text("Inicio da execução"),
                subtitle:
                    const Text("Passos para iniciar a execução do modelo"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaginaAdicionarBloco(
                        titulo: "Inicio da execução",
                        tipo: "inicio",
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Execução do modelo"),
                subtitle: const Text("Passos para a execução do modelo"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaginaAdicionarBloco(
                        titulo: "Execução do modelo",
                        tipo: "execucao",
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Final da execução"),
                subtitle:
                    const Text("Passos para finalizar a execução do modelo"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaginaAdicionarBloco(
                        titulo: "Final da execução",
                        tipo: "final",
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              ...List.generate(
                funcoes.length,
                (index) {
                  String descricao = funcoes[index].lacoDeRepeticao
                      ? "\nLaço de repetição: ${funcoes[index].tempoDeRepeticao > 0 ? "${funcoes[index].tempoDeRepeticao} ms" : "Infinito"}"
                      : "";
                  return ListTile(
                    title: Text(funcoes[index].nome),
                    subtitle: Text(funcoes[index].descricao + descricao),
                    trailing: IconButton(
                      onPressed: () {
                        Modelo.removerFuncao(indice: index);
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaginaAdicionarBloco(
                            titulo: funcoes[index].nome,
                            tipo: index.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
