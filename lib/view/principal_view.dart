import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/model/trator_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? tratorSelecionado;
  String? valorSelecionado;
  final TextEditingController _valorController = TextEditingController();
  List<DadosApi> tratores = []; // Lista para armazenar os tratores

  @override
  void initState() {
    super.initState();
    // Chama o método para buscar tratores
    _fetchTratores();
  }

  // Método para buscar tratores da API
  Future<void> _fetchTratores() async {
    try {
      TratorService service = TratorService();
      List<DadosApi> response = await service.tratores();
      setState(() {
        tratores = response; // Armazena os tratores recebidos
      });
    } catch (e) {
      // Lidar com erro (exibir mensagem, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar tratores: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Center(
            child: Text('ABASTECIMENTO'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 220,
                height: 50,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                  ),
                  hint: Text('Selecione uma opção'),
                  value: tratorSelecionado,
                  onChanged: (newValue) {
                    setState(() {
                      tratorSelecionado = newValue;
                    });
                  },
                  items: tratores.map<DropdownMenuItem<String>>((DadosApi trator) {
                    return DropdownMenuItem<String>(
                      value: trator.id.toString(), // Aqui, use o ID do trator
                      child: Text(trator.nome), // Exibe o nome do trator
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 180,
                child: TextField(
                  controller: _valorController,
                  decoration: InputDecoration(
                    hintText: 'Insira o valor',
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  valorSelecionado = _valorController.text;
                  if (tratorSelecionado != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Abastecendo $valorSelecionado no $tratorSelecionado, aguarde!!',
                        ),
                      ),
                    );
                    setState(() {
                      _valorController.clear();
                      tratorSelecionado = null;
                    });
                  }
                },
                child: Text('ABASTECER'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
