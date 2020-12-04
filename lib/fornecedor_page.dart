import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'model/fornecedor.dart';

void main() async {
  //Registrar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   initialRoute: '/principal',
  //   routes: {
  //     '/principal': (context) => FornecedorPage(),
  //     '/cadastro': (context) => TelaCadastro(),
  //   },
  // ));
}

//
// TELA PRINCIPAL
//
class FornecedorPage extends StatefulWidget {
  @override
  _FornecedorPageState createState() => _FornecedorPageState();
}

class _FornecedorPageState extends State<FornecedorPage> {
  var db = FirebaseFirestore.instance;

  List<Fornecedor> fornecedor = List();

  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState() {
    super.initState();

    ouvidor?.cancel();

    ouvidor = db.collection("fornecedor").snapshots().listen((res) {
      setState(() {
        fornecedor =
            res.docs.map((e) => Fornecedor.fromMap(e.data(), e.id)).toList();
      });
    });
  }

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
          backgroundColor: Theme.of(context).primaryColor),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("fornecedor").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("Erro ao conectar no FireBase"),
              );
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                itemCount: fornecedor.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(fornecedor[index].razaoSocial,
                        style: TextStyle(fontSize: 24)),
                    subtitle: Text(
                        fornecedor[index].endereco +
                            '\n' +
                            fornecedor[index].cidade +
                            '\n' +
                            fornecedor[index].telefone +
                            '\n' +
                            fornecedor[index].cnpj,
                        style: TextStyle(fontSize: 18)),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Apagar o documento selecionado
                          db
                              .collection("fornecedor")
                              .doc(fornecedor[index].id)
                              .delete();
                        }),
                    onTap: () {
                      // Abrir a tela de Cadastro passando o ID
                      // do documento como parâmetro
                      Navigator.pushNamed(context, '/cadastro',
                          arguments: fornecedor[index].id);
                    },
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/cadastro", arguments: null);
        },
      ),
      backgroundColor: Colors.cyan[50],
    );
  }
}

//
// TELA CADASTRO
//
class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtCidade = TextEditingController();
  var txtCnpj = TextEditingController();
  var txtEndereco = TextEditingController();
  var txtRazaoSocial = TextEditingController();
  var txtTelefone = TextEditingController();

  var db = FirebaseFirestore.instance;

  // Recuperar um DOCUMENTO a partir do ID
  void getDocumentById(String id) async {
    await db.collection("fornecedor").doc(id).get().then((doc) {
      txtCidade.text = doc.data()['cidade'];
      txtCnpj.text = doc.data()['cnpj'];
      txtEndereco.text = doc.data()['endereco'];
      txtRazaoSocial.text = doc.data()['razaoSocial'];
      txtTelefone.text = doc.data()['telefone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    if (id != null) {
      if (txtCidade.text == '' &&
          txtCnpj.text == '' &&
          txtEndereco.text == '' &&
          txtRazaoSocial.text == '' &&
          txtTelefone.text == '') {
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Cafeteria Sweet Coffe'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor),
      body: Container(
          padding: EdgeInsets.all(50),
          child: Column(children: [
            TextField(
              controller: txtRazaoSocial,
              style:
                  TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Razão Social",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtEndereco,
              style:
                  TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Endereço",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtCidade,
              style:
                  TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Cidade",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtTelefone,
              style:
                  TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Telefone",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtCnpj,
              style:
                  TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "CNPJ",
              ),
            ),
            SizedBox(
              height: 30,
            ),

//BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: Colors.cyan[500],
                    child: Text("salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () async {
                      if (id == null) {
                        //ADICIONAR um novo DOCUMENTO a COLEÇÃO
                        await db.collection("fornecedor").add(
                            {"cidade": txtCidade.text, "cnpj": txtCnpj.text, "endereco": txtEndereco.text, "razaoSocial": txtRazaoSocial.text, "telefone": txtTelefone.text});
                      } else {
                        // ATUALIZAR DADOS DO DOCUMENTO
                        await db.collection("fornecedor").doc(id).update(
                            {"cidade": txtCidade.text, "cnpj": txtCnpj.text, "endereco": txtEndereco.text, "razaoSocial": txtRazaoSocial.text, "telefone": txtTelefone.text});
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: Colors.cyan[500],
                    child: Text("cancelar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ])),
      backgroundColor: Colors.cyan[50],
    );
  }
}
