import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart'; // Importando a biblioteca overlay_support

void main() {
  runApp(OverlaySupport.global(child: MyApp())); // Habilitando a sobreposição global
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verificador de Corridas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CorridaScreen(), // CorridaScreen sem erro de key
    );
  }
}

class CorridaScreen extends StatefulWidget {
  const CorridaScreen({super.key});  // Adicionando o Key aqui

  @override
  CorridaScreenState createState() => CorridaScreenState();  // Correção aqui
}

class CorridaScreenState extends State<CorridaScreen> {
  String message = "Aguardando Corrida...";

  // Função para exibir a mensagem sobreposta
  void mostrarMensagem(String mensagem, Color cor) {
    showOverlay(
          (context, t) => Material(
        color: Colors.transparent,
        child: Center(
          child: AnimatedOpacity(
            opacity: t,
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.all(20),
              color: cor,
              child: Text(
                mensagem,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Função simulada para verificar a corrida
  void verificarCorrida() {
    // Simulação de cálculo do valor por km
    double valorPorKm = 5.0; // Simulação de valor
    double distancia = 10.0; // Distância da corrida (em km)

    double valorTotal = valorPorKm * distancia;

    // Exibir mensagens de acordo com o valor da corrida
    if (valorTotal >= 30.0) {  // Se o valor total for acima de 30, é uma corrida boa
      mostrarMensagem("Corrida Boa! Valor: \$${valorTotal.toStringAsFixed(2)}", Colors.green);
    } else if (valorTotal < 30.0 && valorTotal >= 15.0) {
      mostrarMensagem("Corrida Ruim. Valor: \$${valorTotal.toStringAsFixed(2)}", Colors.red);
    } else {
      mostrarMensagem("Corrida Ruim! Valor: \$${valorTotal.toStringAsFixed(2)}", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Corridas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verificarCorrida, // Verifica a corrida ao pressionar
              child: const Text('Verificar Corrida'),
            ),
          ],
        ),
      ),
    );
  }
}
