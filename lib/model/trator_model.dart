class DadosApi {
  int id;
  String nome;


  DadosApi(this.id, this.nome);

  factory DadosApi.fromJson(Map json){
    return DadosApi(
      json['id'],
      json['nome'],
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
    };
  }

}