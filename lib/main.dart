import 'package:flutter/material.dart';
import 'CalculadoraViaje.dart';
import 'Auto.dart';
import 'Combustible.dart';
import 'Destino.dart';

void main() => runApp(ViajeApp());

class ViajeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Viaje',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViajeHomePage(),
    );
  }
}


class ViajeHomePage extends StatefulWidget {
  @override
  _ViajeHomePageState createState() => _ViajeHomePageState();
}

class _ViajeHomePageState extends State<ViajeHomePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para los campos de texto
  final TextEditingController _autoController = TextEditingController();
  final TextEditingController _consumoController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _precioCombustibleController = TextEditingController();

  double? _costoViaje;

 void _calcularCostoViaje() {
  if (_formKey.currentState!.validate()) {
    // Crear el objeto Auto
    Auto auto = Auto(
      nombre: _autoController.text,
      consumoPorKm: double.parse(_consumoController.text),
    );
    
    // Crear el objeto Destino (ajustando 'lugar' en vez de 'nombreDestino')
    Destino destino = Destino(
      lugar: _destinoController.text,
      kilometros: double.parse(_kmController.text),
    );

    // Crear el objeto Combustible con todos los parámetros requeridos
    Combustible combustible = Combustible(
      precioPorLitro: double.parse(_precioCombustibleController.text),
      litrosComprados: 50, // Puedes modificar este valor o permitir al usuario ingresarlo
      fecha: DateTime.now(), // Asignar la fecha actual o pedir al usuario ingresarla
    );

    // Usar la clase CalculadoraViaje para hacer el cálculo
    double costo = CalculadoraViaje.calcularCostoViaje(auto, destino, combustible);

    setState(() {
      _costoViaje = costo;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Costo de Viaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _autoController,
                decoration: InputDecoration(labelText: 'Nombre del Auto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del auto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _consumoController,
                decoration: InputDecoration(labelText: 'Consumo por Km (litros/km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el consumo del auto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinoController,
                decoration: InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el destino';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kmController,
                decoration: InputDecoration(labelText: 'Kilómetros a recorrer'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los kilómetros';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioCombustibleController,
                decoration: InputDecoration(labelText: 'Precio por litro de combustible'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio del combustible';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularCostoViaje,
                child: Text('Calcular Costo del Viaje'),
              ),
              SizedBox(height: 20),
              if (_costoViaje != null)
                Text(
                  'El costo del viaje es: \$${_costoViaje!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
