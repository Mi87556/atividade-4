import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraIMC());
}

class CalculadoraIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = "";

  void _limparCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _resultado = "";
    });
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100; // cm para m
      double imc = peso / (altura * altura);

      String classificacao = "";
      if (imc < 18.5) {
        classificacao = "Abaixo do peso";
      } else if (imc < 25) {
        classificacao = "Peso ideal";
      } else if (imc < 30) {
        classificacao = "Sobrepeso";
      } else {
        classificacao = "Obesidade";
      }

      setState(() {
        _resultado =
            "IMC: ${imc.toStringAsFixed(2)}\nClassificação: $classificacao";
      });
    }
  }

  Widget _campoTexto(
      String label, String msgErro, TextEditingController controlador) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controlador,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msgErro;
        }
        return null;
      },
    );
  }

  Widget _botao(String texto, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(texto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _campoTexto("Peso (kg)", "Insira seu peso", _pesoController),
              _campoTexto("Altura (cm)", "Insira sua altura", _alturaController),
              _botao("Calcular IMC", _calcularIMC),
              SizedBox(height: 20),
              Text(
                _resultado,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
