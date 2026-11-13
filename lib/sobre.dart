import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 54,
                backgroundColor: Color(0xFFE4F2E9),
                child: Icon(Icons.local_gas_station, size: 58, color: Color(0xFF168447)),
              ),
              const SizedBox(height: 24),
              Text('Desenvolvido por', style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
              const SizedBox(height: 6),
              const Text(
                'Wallace Henrique',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF168447)),
              ),
              const SizedBox(height: 16),
              const Text('Turma: 2026/1', style: TextStyle(fontSize: 17)),
              const SizedBox(height: 28),
              const Text('Objetivo do aplicativo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                'Calcular o consumo médio de combustível de um veículo em quilômetros por litro (km/l), a partir da distância percorrida e da quantidade de litros consumidos, apresentando também uma classificação do resultado.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, height: 1.5, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
