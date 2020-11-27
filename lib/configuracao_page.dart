import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var txtProduto = TextEditingController();
  var items = List<String>();

  @override
  void initState() {
    items.add("Café Extraforte");
    items.add("Café Tradicional");
    items.add("Capuccino Tradicional");
    items.add("Capuccino Light");
    items.add("Leite Sem Lactose");
    items.add("Leite Desnatado");
    items.add("Achocolatado");
    items.add("Refrigerante");
    items.add("Suco Natural");
    items.add("Bolo de Chocolate");

    super.initState();
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
        title: Text('Cafeteria Sweet Coffe'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [IconButton(icon: Icon(Icons.favorite))],
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
                    controller: txtProduto,
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
                      items.add(txtProduto.text);
                      items.sort();
                      txtProduto.text = '';
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Produto adicionado com sucesso.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  //reverse: true,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        leading: Icon(Icons.local_cafe),
                        title:
                            Text(items[index], style: TextStyle(fontSize: 24)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            setState(() {
                              items.removeAt(index);

                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Produto removido com sucesso.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 1, color: Colors.grey);
                  },
                  itemCount: items.length),
            ),
          ],
        ),
      ),
    );
  }
}
