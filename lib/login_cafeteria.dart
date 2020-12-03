import 'dart:async';

import 'package:cafeteria_projeto_avaliativo/model/usuario.dart';
import 'package:cafeteria_projeto_avaliativo/resetar_senha.dart';

import 'package:cafeteria_projeto_avaliativo/home.dart';
import 'package:cafeteria_projeto_avaliativo/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  final db = FirebaseFirestore.instance;
  final String colecao = "usuario";

  //Lista dinâmica para manipulação dos dados
  List<Usuario> listaDeUsuarios = List<Usuario>();

  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection("usuario").snapshots().listen((res) {
      debugPrint('CHEGOOOU');
      var teste = res.docs.toList();
      debugPrint('res: $teste');

      setState(() {
        listaDeUsuarios =
            res.docs.map((doc) => Usuario.fromMap(doc.data(), doc.id)).toList();

        debugPrint('listaDeUsuarios: $listaDeUsuarios');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Usuario> listaDeUsuarios = ModalRoute.of(context).settings.arguments;

    var txtEmail = TextEditingController();
    var txtSenha = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cafeteria Sweet Coffe'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [IconButton(icon: Icon(Icons.favorite))],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
                width: 128,
                height: 128,
                child: Image.asset('imagens/cafe.jpg')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: txtSenha,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0XFF2AD9E0),
                    Color(0XFF2C9AAC),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset('imagens/grao-de-cafe.png'),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    // // botaoLogar(context);
                    // Usuario usuario =
                    //     new Usuario(null, null, txtEmail.text, txtSenha.text);

                    String email = txtEmail.text;
                    String senha = txtSenha.text;

                    bool ok = false;

                    debugPrint('listaDeUsuarios: $listaDeUsuarios');

                    listaDeUsuarios.forEach((element) {
                      debugPrint('usuario email: ${email}');
                      debugPrint('usuario senha: ${senha}');
                      debugPrint('element email: ${element.email}');
                      debugPrint('element senha: ${element.senha}');

                      debugPrint('email: ${email == element.email}');
                      debugPrint('senha: ${element.senha == senha}');
                      if (element.email == email && element.senha == senha) {
                        ok = true;
                      }
                    });
                    debugPrint('ok: $ok');
                    if (ok) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    } else {
                        return mostraAlert(context);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  mostraAlert(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        //botaoLogar(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Erro!"),
      content: Text("Email ou senha inválidos."),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
