import 'dart:convert';
import 'package:frontend/model/trator_model.dart';
import 'package:http/http.dart' as http;

class TratorService {
  // RETORNA uma lista de estados
  Future<List<DadosApi>> tratores() async {
    final resposta = await http.get(
      Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/?orderby=nome',
      ),
    );

    if (resposta.statusCode == 200) {
      List<dynamic> data = json.decode(resposta.body);
      return data.map((item) => DadosApi.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar dados: ${resposta.statusCode}');
    }
  }
}
