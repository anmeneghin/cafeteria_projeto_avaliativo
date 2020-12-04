import 'package:cafeteria_projeto_avaliativo/cafe_page.dart';
import 'package:cafeteria_projeto_avaliativo/info_page.dart';
import 'package:cafeteria_projeto_avaliativo/configuracao_page.dart';
import 'package:cafeteria_projeto_avaliativo/menu_page.dart';

import 'package:flutter/material.dart';

import 'fornecedor_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final widgetOptions = [
    new MenuPage(),
    new FornecedorPage(),
    new ConfigPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping), title: Text('Fornecedores')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe), title: Text('Produtos')),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: onItemTapped,
      ),
    );
  }
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
