import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/operation.dart';

/// Enum que define los tipos de operación posibles
enum TipoOperacion { suma, resta, multiplicacion, division, igual }

/// Cubit que maneja el estado del resultado de la operación
class CalculadoraCubit extends Cubit<String> {
  CalculadoraCubit() : super('');

  void calcular(TipoOperacion tipoOperacion, Operation op) {
    double resultado = 0;

    switch (tipoOperacion) {
      case TipoOperacion.suma:
        resultado = op.firstNumber + op.secondNumber;
        break;
      case TipoOperacion.resta:
        resultado = op.firstNumber - op.secondNumber;
        break;
      case TipoOperacion.multiplicacion:
        resultado = op.firstNumber * op.secondNumber;
        break;
      case TipoOperacion.division:
        if (op.secondNumber == 0) {
          emit("Error: División por 0");
          return;
        }
        resultado = op.firstNumber / op.secondNumber;
        break;
      case TipoOperacion.igual:
        return;
    }

    emit(
      resultado.toStringAsFixed(2),
    ); // Mostramos el resultado con dos decimales
  }

  void limpiar() => emit('');
}
