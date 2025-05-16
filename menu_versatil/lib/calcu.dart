import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Angel_Duran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0046AD),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0046AD)),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();
  String _operacion = '+';
  double _resultado = 0;

  @override
  void initState() {
    super.initState();
    _numero1Controller.text = '50';
    _numero2Controller.text = '1';
    _calcular();
  }

  void _calcular() {
    double num1 = double.tryParse(_numero1Controller.text) ?? 0;
    double num2 = double.tryParse(_numero2Controller.text) ?? 0;

    setState(() {
      switch (_operacion) {
        case '+':
          _resultado = num1 + num2;
          break;
        case '-':
          _resultado = num1 - num2;
          break;
        case 'x':
          _resultado = num1 * num2;
          break;
        case '÷':
          _resultado = num2 != 0 ? num1 / num2 : 0;
          break;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _numero1Controller.text = '';
      _numero2Controller.text = '';
      _operacion = '+';
      _resultado = 0;
    });
  }

  String _getNombreOperacion() {
    switch (_operacion) {
      case '+':
        return 'Suma';
      case '-':
        return 'Resta';
      case 'x':
        return 'Multiplicación';
      case '÷':
        return 'División';
      default:
        return 'Suma';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Image.asset(
                    'assets/casio.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),

                // Campos de entrada
                _buildInputField('Número 1 :', _numero1Controller),
                const SizedBox(height: 16),
                _buildInputField('Número 2 :', _numero2Controller),
                const SizedBox(height: 16),

                // Resultado
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    'Resultado [${_getNombreOperacion()}]: ${_resultado.toStringAsFixed(_resultado.truncateToDouble() == _resultado ? 0 : 2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0046AD),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOperationButton('+'),
                    _buildOperationButton('-'),
                    _buildOperationButton('x'),
                    _buildOperationButton('÷'),
                  ],
                ),

                const SizedBox(height: 16),

                // Botón de limpiar
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _limpiar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0046AD),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Limpiar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0046AD),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 16),
              onChanged: (_) => _calcular(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationButton(String operation) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _operacion = operation;
          _calcular();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _operacion == operation ? const Color(0xFF0046AD) : Colors.white,
        foregroundColor:
            _operacion == operation ? Colors.white : const Color(0xFF0046AD),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        operation,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }
}
