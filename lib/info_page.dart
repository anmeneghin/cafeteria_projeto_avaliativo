import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  Widget titleSection = Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Informações',
          style: TextStyle(
            color: new Color(0XFF000200),
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
    ],
  ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafeteria Sweet Coffe'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [IconButton(icon: Icon(Icons.favorite))],
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: ListView(
          children: [
            titleSection,
            Container(
              padding: EdgeInsets.all(60),
              child: Column(
                children: [
                  Text(
                    'Tema: ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Sistema para uma Cafeteria',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Objetivos: ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      'Este aplicativo tem como objetivo auxiliar na gerência de uma cafeteria.',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Desenvolvido por: ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Amanda Nogueira Meneghin',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 128,
                      height: 128,
                      child: Image.asset(
                        'imagens/amanda.jpeg',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
