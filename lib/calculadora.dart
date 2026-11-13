import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sobre.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final _quilometrosController = TextEditingController();
  final _litrosController = TextEditingController();

  String _consumoText = 'Informe os dados e toque em Calcular.';
  String? _classificacao;
  Color _resultadoCor = const Color(0xFF168447);
  IconData _resultadoIcone = Icons.local_gas_station_outlined;

  @override
  void dispose() {
    _quilometrosController.dispose();
    _litrosController.dispose();
    super.dispose();
  }

  double? _lerNumero(String valor) =>
      double.tryParse(valor.trim().replaceAll(',', '.'));

  void _calcular() {
    final quilometros = _lerNumero(_quilometrosController.text);
    final litros = _lerNumero(_litrosController.text);

    if (quilometros == null || litros == null) {
      _mostrarErro('Preencha os dois campos com números válidos.');
      return;
    }
    if (quilometros < 0 || litros <= 0) {
      _mostrarErro('O valor dos quilômetros não pode ser negativo e litros deve ser maior que zero.');
      return;
    }

    final consumo = quilometros / litros;
    final String classificacao;
    final Color cor;
    final IconData icone;
    if (consumo < 8) {
      classificacao = 'Consumo Alto';
      cor = Colors.red.shade700;
      icone = Icons.warning_amber_rounded;
    } else if (consumo <= 12) {
      classificacao = 'Consumo Médio';
      cor = Colors.orange.shade800;
      icone = Icons.directions_car_outlined;
    } else {
      classificacao = 'Consumo Econômico';
      cor = const Color(0xFF168447);
      icone = Icons.eco_outlined;
    }
    setState(() {
      _consumoText = 'Consumo: ${consumo.toStringAsFixed(1).replaceAll('.', ',')} km/l';
      _classificacao = classificacao;
      _resultadoCor = cor;
      _resultadoIcone = icone;
    });
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _limpar() {
    _quilometrosController.clear();
    _litrosController.clear();
    setState(() {
      _consumoText = 'Informe os dados e toque em Calcular.';
      _classificacao = null;
      _resultadoCor = const Color(0xFF168447);
      _resultadoIcone = Icons.local_gas_station_outlined;
    });
  }

  void _abrirSobre() => Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const SobrePage()),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF168447)),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'App Combustível',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calculate_outlined, color: Color(0xFF168447)),
                title: const Text('Calculadora'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Color(0xFF168447)),
                title: const Text('Sobre'),
                onTap: () {
                  Navigator.pop(context);
                  _abrirSobre();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Consumo de Combustível', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Sobre o aplicativo',
            onPressed: _abrirSobre,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Icon(Icons.local_gas_station, size: 86, color: Color(0xFF168447)),
              const SizedBox(height: 12),
              const Text(
                'Calculadora de consumo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Descubra quantos quilômetros seu veículo percorre por litro.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 28),
              _campo(
                controller: _quilometrosController,
                label: 'Quilômetros percorridos',
                dica: 'Ex.: 250',
                icone: Icons.route,
              ),
              const SizedBox(height: 16),
              _campo(
                controller: _litrosController,
                label: 'Litros consumidos',
                dica: 'Ex.: 20',
                icone: Icons.water_drop_outlined,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _calcular,
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('CALCULAR'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF168447),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _limpar,
                  icon: const Icon(Icons.cleaning_services_outlined),
                  label: const Text('LIMPAR'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF168447),
                    side: const BorderSide(color: Color(0xFF168447)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(_resultadoIcone, size: 42, color: _resultadoCor),
                      const SizedBox(height: 10),
                      Text(
                        _consumoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _resultadoCor, fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      if (_classificacao != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          _classificacao!,
                          style: TextStyle(color: _resultadoCor, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Classificação: abaixo de 8 km/l = alto • 8 a 12 km/l = médio • acima de 12 km/l = econômico',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 34,
        color: const Color(0xFF168447),
        padding: EdgeInsets.zero,
        child: const Center(
          child: Text(
            'Desenvolvido por Wallace Henrique',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required String dica,
    required IconData icone,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        hintText: dica,
        prefixIcon: Icon(icone, color: const Color(0xFF168447)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF168447), width: 2),
        ),
      ),
    );
  }
}
