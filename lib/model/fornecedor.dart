class Fornecedor {

  String id;
  String razaoSocial;
  String cnpj;
  String cidade;
  String endereco;
  String telefone;

  Fornecedor(this.id,this.cidade,this.cnpj,this.endereco,this.razaoSocial,this.telefone);

  // Converter um DOCUMENTO em OBJETO

  Fornecedor.fromMap(Map<String,dynamic>map, String id) {
    // Se o parâmetro id != null, então this.id = id,
    //Senão, this.id = '';
    this.id = id ?? '';
    this.cidade = map['cidade'];
    this.cnpj = map['cnpj'];
    this.endereco = map['endereco'];
    this.razaoSocial = map['razaoSocial'];
    this.telefone = map['telefone'];
  }
}