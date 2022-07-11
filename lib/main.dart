import 'package:flutter/material.dart';

import 'pagina_inicial/pagina_inicial.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simulador",
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const PaginaInicial(),
    );
  }
}
