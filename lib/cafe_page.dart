import 'package:flutter/material.dart';

import 'home.dart';

Widget titleSection = Container(
    child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Café',
        style: TextStyle(
          color: new Color(0XFF000200),
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    ),
  ],
));

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  //Armazer valores do peso e altura
  var txtQuantidade = TextEditingController();
  var txtValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                //debugPrint("botão acionado.");

                setState(() {
                  txtQuantidade.text = "";
                  txtValor.text = "";
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                titleSection,
                Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child:
                                        Image.asset('imagens/cafe_preto.jpg')),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'imagens/cafe_chantilly.jpeg')),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('imagens/cafe.jpg')),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child:
                                        Image.asset('imagens/cafe_copo3.jpeg')),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('imagens/latte.jpeg')),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child:
                                        Image.asset('imagens/cafe_copo2.jpg')),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Expresso',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 2,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Expresso com Chantilly',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 4,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Expresso com Avelã',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 6,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Café Americano',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 3,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Café com leite',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 5,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Capuccino',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('R\$ 6,00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        campoTexto("Digite a quantidade:", txtQuantidade),
                        campoTexto("Digite o valor do item: ", txtValor),
                        botao("Calcular"),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
  Widget campoTexto(rotulo, variavelControle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: variavelControle,
        style: TextStyle(fontSize: 28),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
          ),
        ),
        validator: (value) {
          return (double.tryParse(value) == null)
              ? "Informe um valor numérico"
              : null;
        },
      ),
    );
  }

  //
  // BOTÃO
  //
  Widget botao(rotulo) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: RaisedButton(
        child: Text(
          rotulo,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          //debugPrint("calcular");

          if (formKey.currentState.validate()) {
            setState(() {
              double quant = double.parse(txtQuantidade.text);
              double valor = double.parse(txtValor.text);
              double resultado = quant * valor;
              caixaDialogo('Valor: ${resultado.toStringAsFixed(2)}');
            });
          }
        },
      ),
    );
  }

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Total a pagar', style: TextStyle(fontSize: 12)),
            content: Text(msg, style: TextStyle(fontSize: 16)),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('fechar'))
            ],
          );
        });
  }
}
