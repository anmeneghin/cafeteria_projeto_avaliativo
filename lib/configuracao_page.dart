import 'dart:async';

import 'package:cafeteria_projeto_avaliativo/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/produto.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var txtNome = TextEditingController();
  String idSelecionado = null;

  final db = FirebaseFirestore.instance;
  final String colecao = "produto";

  //Lista dinâmica para manipulação dos dados
  List<Produto> listaDeProdutos = List<Produto>();

  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    // items.add("Café Extraforte");
    // items.add("Café Tradicional");
    // items.add("Capuccino Tradicional");
    // items.add("Capuccino Light");
    // items.add("Leite Sem Lactose");
    // items.add("Leite Desnatado");
    // items.add("Achocolatado");
    // items.add("Refrigerante");
    // items.add("Suco Natural");
    // items.add("Bolo de Chocolate");

    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection("produto").snapshots().listen((res) {
      setState(() {
        listaDeProdutos =
            res.docs.map((doc) => Produto.fromMap(doc.data(), doc.id)).toList();
      });
    });
  }

  Widget titleSection = Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Configurações dos Produtos',
          style: TextStyle(
            color: new Color(0XFF000200),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    ],
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
      ), 
        title: Text('Cafeteria Sweet Coffe'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleSection,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtNome,
                    decoration: InputDecoration(
                      labelText: 'Adicionar Produto',
                    ),
                  ),
                ),
                SizedBox(width: 30),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      // listaDeProdutos.add(txtNome.text);
                      // listaDeProdutos.sort();
                      if(idSelecionado == null){
                        db
                            .collection(colecao)
                            .add({'nome': txtNome.text})
                            .then((value) => {
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Produto adicionado com sucesso.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  )
                                })
                            .catchError((error) => print("Erro ao cadastrar"));
                      }
                      else{
                         db
                            .collection(colecao)
                            .doc(idSelecionado)
                            .update({'nome': txtNome.text})
                            .then((value) => {
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Produto editado com sucesso.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  )
                                })
                            .catchError((error) => print("Erro ao cadastrar"));
                      }
                    });
                    txtNome.text = '';
                    idSelecionado = null;
                  },
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection("produto").snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                              child: Text("Erro ao conectar no Firebase"));
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          return ListView.separated(
                              //reverse: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: ListTile(
                                    leading: Icon(Icons.local_cafe),
                                    title: Text(listaDeProdutos[index].nome,
                                        style: TextStyle(fontSize: 24)),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      onPressed: () {
                                        setState(() {
                                          db
                                              .collection("produto")
                                              .doc(listaDeProdutos[index].id)
                                              .delete()
                                              .then((value) => {
                                                    scaffoldKey.currentState
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Produto removido com sucesso.'),
                                                        duration: Duration(
                                                            seconds: 3),
                                                      ),
                                                    )
                                                  })
                                              .catchError((error) =>
                                                  print("Erro ao deletar"));
                                        });
                                      },
                                    ),
                                    onTap: () {
                                      idSelecionado = listaDeProdutos[index].id;
                                      txtNome.text = listaDeProdutos[index].nome;

                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                    thickness: 1, color: Colors.grey);
                              },
                              itemCount: listaDeProdutos.length);
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
