import 'Auto.dart';
import 'Combustible.dart';
import 'Destino.dart';


class CalculadoraViaje {
  static double calcularCostoViaje(Auto auto, Destino destino, Combustible combustible) {
    double litrosNecesarios = destino.kilometros * auto.consumoPorKm;
    return litrosNecesarios * combustible.precioPorLitro;
  }
}