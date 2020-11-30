import 'package:flutter/foundation.dart';

class Produto {
  String _id;
  String _nome;


  Produto(this._id, this._nome);

  String get id => _id;
  String get nome => _nome;


  Produto.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nome"] = _nome;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Produto.fromMap(Map<String, dynamic> map, String id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).

    this._id = id ?? '';
    this._nome = map['nome'];
  }
}
