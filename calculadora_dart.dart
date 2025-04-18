// !Que veremos hoy:
//primera libreria dart
// Operaciones basicas
//Entrada de datos y salida de datos - #print #stdout.write #stdin.readLineSync
//funciones basicas
//condicionales

//calculador
import "dart:io";

void main() {
  print('Calculadora');
  stdout.write('Ingrese el primer numero: ');
  double num1 = double.parse(stdin.readLineSync()!);
  stdout.write('Ingrese el segundo numero: ');
  double num2 = double.parse(stdin.readLineSync()!);

  print('eljija una opcion:');
  print('1. Sumar');
  print('2. Restar');
  print('3. Multiplicar');

  int opcion = int.parse(stdin.readLineSync()!);

  double resultado = 0;

  switch (opcion) {
    case 1:
      resultado = sumar(num1, num2);
      break;
    case 2:
      resultado = restar(num1, num2);
      break;
    case 3:
      resultado = multiplicar(num1, num2);
      break;
    default:
      print('Opcion no valida');
      return;
  }
  print('El resultado es: $resultado');
}

double sumar(double num1, double num2) {
  return num1 + num2;
}

double restar(double num1, double num2) {
  return num1 - num2;
}

double multiplicar(double num1, double num2) {
  return num1 * num2;
}
