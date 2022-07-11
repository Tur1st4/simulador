import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simulador/classes/comando.dart';
import 'package:simulador/classes/esperar.dart';
import 'package:simulador/classes/funcao.dart';

import '../classes/modelo.dart';
import '../pagina_adicionar_bloco/adicionar_comando.dart';
import '../pagina_adicionar_bloco/adicionar_espera.dart';
import '../pagina_adicionar_bloco/adicionar_funcao.dart';

class PaginaAdicionarBloco extends StatefulWidget {
  final String titulo;
  final String tipo;
  const PaginaAdicionarBloco({
    Key? key,
    required this.titulo,
    required this.tipo,
  }) : super(key: key);

  @override
  State<PaginaAdicionarBloco> createState() => _PaginaAdicionarBlocoState();
}

class _PaginaAdicionarBlocoState extends State<PaginaAdicionarBloco> {
  List<Object> objetos = <Object>[];
  late StreamSubscription inscricaoDosObjetos;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch (widget.tipo) {
        case "inicio":
          setState(() {
            objetos = Modelo.blocoInicial;
          });

          inscricaoDosObjetos =
              EstadoDoModelo.estadoDoBlocoInicial.listen((event) {
            setState(() {
              objetos = event;
            });
          });
          break;
        case "execucao":
          setState(() {
            objetos = Modelo.blocoDeExecucao;
          });

          inscricaoDosObjetos =
              EstadoDoModelo.estadoDoBlocoDeExecucao.listen((event) {
            setState(() {
              objetos = event;
            });
          });
          break;
        case "final":
          setState(() {
            objetos = Modelo.blocoFinal;
          });

          inscricaoDosObjetos =
              EstadoDoModelo.estadoDoBlocoFinal.listen((event) {
            setState(() {
              objetos = event;
            });
          });
          break;
        default:
          int indice = int.parse(widget.tipo);

          setState(() {
            objetos = Modelo.funcoes[indice].funcoes;
          });

          inscricaoDosObjetos =
              Modelo.funcoes[indice].estadoDeFuncoes.listen((event) {
            setState(() {
              objetos = event;
            });
          });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    inscricaoDosObjetos.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar: ${widget.titulo}"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Escolha uma opção"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Comando"),
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AdicionarComando(
                                tipo: widget.tipo,
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: const Text("Esperar"),
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AdicionarEspera(
                                tipo: widget.tipo,
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        title: const Text("Função"),
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AdicionarFuncao(
                                tipo: widget.tipo,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            objetos.length,
            (index) {
              switch (objetos[index].runtimeType) {
                case Funcao:
                  Funcao objeto = objetos[index] as Funcao;
                  return ListTile(
                    title: Text(objeto.nome),
                    subtitle: Text(objeto.descricao),
                    trailing: IconButton(
                      onPressed: () {
                        switch (widget.tipo) {
                          case "inicio":
                            Modelo.removerDoBlocoInicial(
                              indice: index,
                            );
                            break;
                          case "execucao":
                            Modelo.removerDoBlocoDeExecucao(
                              indice: index,
                            );
                            break;
                          case "final":
                            Modelo.removerDoBlocoFinal(
                              indice: index,
                            );
                            break;
                          default:
                            int indice = int.parse(widget.tipo);

                            Modelo.funcoes[indice].removerFuncao(
                              indice: index,
                            );
                        }
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  );
                case Esperar:
                  Esperar objeto = objetos[index] as Esperar;

                  return ListTile(
                    title: const Text("Esperar"),
                    subtitle: Text(
                      "Tempo de espera: ${objeto.tempoDeEspera} ms",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        switch (widget.tipo) {
                          case "inicio":
                            Modelo.removerDoBlocoInicial(
                              indice: index,
                            );
                            break;
                          case "execucao":
                            Modelo.removerDoBlocoDeExecucao(
                              indice: index,
                            );
                            break;
                          case "final":
                            Modelo.removerDoBlocoFinal(
                              indice: index,
                            );
                            break;
                          default:
                            int indice = int.parse(widget.tipo);

                            Modelo.funcoes[indice].removerFuncao(
                              indice: index,
                            );
                        }
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  );
                case Comando:
                  Comando objeto = objetos[index] as Comando;

                  return ListTile(
                    title: const Text("Comando"),
                    subtitle: Text("Recurso: ${objeto.recurso}"),
                    trailing: IconButton(
                      onPressed: () {
                        switch (widget.tipo) {
                          case "inicio":
                            Modelo.removerDoBlocoInicial(
                              indice: index,
                            );
                            break;
                          case "execucao":
                            Modelo.removerDoBlocoDeExecucao(
                              indice: index,
                            );
                            break;
                          case "final":
                            Modelo.removerDoBlocoFinal(
                              indice: index,
                            );
                            break;
                          default:
                            int indice = int.parse(widget.tipo);

                            Modelo.funcoes[indice].removerFuncao(
                              indice: index,
                            );
                        }
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
