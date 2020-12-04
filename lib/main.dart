import 'package:flutter/material.dart';
import 'package:cafeteria_projeto_avaliativo/login_cafeteria.dart';

import 'fornecedor_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Coffe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LoginPage(),
      routes: {
      '/principal': (context) => FornecedorPage(),
      '/cadastro': (context) => TelaCadastro(),
    },
    );
  }
}
