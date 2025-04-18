import 'package:calculadora_flutter/config/theme.dart';
import 'package:calculadora_flutter/controller/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/calculadora_cubit.dart';
import '../model/operation.dart';

/// Página principal de la calculadora
class CalculadoraPage extends StatefulWidget {
  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String displayNumber = '';
  String firstNumber = '';
  String secondNumber = '';
  TipoOperacion? currentOperation;

  /// Agrega dígitos o punto decimal al número actual
  void onNumberPressed(String number) {
    setState(() {
      if (currentOperation == null) {
        if (number == '.' && firstNumber.contains('.')) return;
        firstNumber += number;
        displayNumber = firstNumber;
      } else {
        if (number == '.' && secondNumber.contains('.')) return;
        secondNumber += number;
        displayNumber = secondNumber;
      }
    });
  }

  /// Ejecuta la operación usando el cubit
  void ejecutarOperacion(TipoOperacion tipo) {
    if (tipo != TipoOperacion.igual) {
      if (firstNumber.isEmpty) return;
      currentOperation = tipo;
      setState(() {});
      return;
    }
    if (secondNumber.isEmpty || currentOperation == null) return;
    try {
      // Primero realiza la operación
      final op = Operation(
        firstNumber: double.parse(firstNumber),
        secondNumber: double.parse(secondNumber),
      );

      /// Usamos context.read porque solo necesitamos ejecutar una acción
      /// y no necesitamos escuchar cambios de estado
      context.read<CalculadoraCubit>().calcular(currentOperation!, op);
      // Luego obtiene el resultado y lo guarda como primer número
      firstNumber = context.read<CalculadoraCubit>().state;
      displayNumber = firstNumber;
      // Limpia el segundo número y la operación
      secondNumber = '';
      currentOperation = null;
      setState(() {});
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error en la operación")));
    }
  }

  void limpiarCalculadora() {
    firstNumber = '';
    secondNumber = '';
    displayNumber = '';
    currentOperation = null;
    context.read<CalculadoraCubit>().limpiar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        actions: [
          IconButton(
            icon: Icon(
              /// Usamos context.watch porque necesitamos que el icono se actualice
              /// cada vez que cambie el estado del tema
              context.watch<ThemeCubit>().state == ThemeState.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),

            /// Usamos context.read porque solo necesitamos llamar al método
            /// y no necesitamos reconstruir el widget cuando cambie el estado
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Display donde se muestra el número actual y el resultado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayNumber.isEmpty ? '0' : displayNumber,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  BlocBuilder<CalculadoraCubit, String>(
                    builder:
                        (_, resultado) => Text(
                          resultado.isEmpty ? '' : 'Resultado: $resultado',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Teclado numérico y de operaciones
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  ...'789456123.0'
                      .split('')
                      .map((n) => _buildButton(n, onNumberPressed)),

                  /// Botones de operación
                  _buildOperationButton(
                    '÷',
                    () => ejecutarOperacion(TipoOperacion.division),
                  ),
                  _buildOperationButton(
                    '×',
                    () => ejecutarOperacion(TipoOperacion.multiplicacion),
                  ),
                  _buildOperationButton(
                    '-',
                    () => ejecutarOperacion(TipoOperacion.resta),
                  ),
                  _buildOperationButton(
                    '+',
                    () => ejecutarOperacion(TipoOperacion.suma),
                  ),
                  _buildOperationButton(
                    '=',
                    () => ejecutarOperacion(TipoOperacion.igual),
                  ),
                ],
              ),
            ),

            /// Botón de limpiar
            OutlinedButton(
              onPressed: limpiarCalculadora,
              child: const Text('Limpiar'),
            ),
          ],
        ),
      ),
    );
  }

  /// Botón numérico
  Widget _buildButton(String text, Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }

  /// Botón de operación (suma, resta, etc.)
  Widget _buildOperationButton(String symbol, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.neonPurple,
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: AppTheme.neonBlue.withOpacity(0.5),
        padding: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
