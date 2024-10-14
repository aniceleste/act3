import 'package:flutter/material.dart';
import 'CalculadoraViaje.dart';
import 'Auto.dart';
import 'Combustible.dart';
import 'Destino.dart';
import 'AgregarAutopage.dart';



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
  
  List<Auto> autos = []; // Lista para almacenar los autos agregados
  Auto? autoSeleccionado;

  // Controladores para los campos de texto
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _precioCombustibleController = TextEditingController();

  double? _costoViaje;

  void _calcularCostoViaje() {
    if (_formKey.currentState!.validate() && autoSeleccionado != null) {
      Destino destino = Destino(
        lugar: _destinoController.text,
        kilometros: double.parse(_kmController.text),
      );

      Combustible combustible = Combustible(
        precioPorLitro: double.parse(_precioCombustibleController.text),
        litrosComprados: 50, // Ajustar según sea necesario
        fecha: DateTime.now(),
      );

      double costo = CalculadoraViaje.calcularCostoViaje(autoSeleccionado!, destino, combustible);

      setState(() {
        _costoViaje = costo;
      });
    }
  }

  // Método para ir a la pantalla de agregar autos
  void _irAgregarAuto() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgregarAutoPage(autos: autos)),
    );
    setState(() {}); // Refrescar la pantalla después de agregar autos
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
              // Dropdown para seleccionar auto
              DropdownButtonFormField<Auto>(
                decoration: InputDecoration(labelText: 'Seleccionar Auto'),
                value: autoSeleccionado,
                items: autos.map((Auto auto) {
                  return DropdownMenuItem<Auto>(
                    value: auto,
                    child: Text(auto.nombre),
                  );
                }).toList(),
                onChanged: (Auto? nuevoAuto) {
                  setState(() {
                    autoSeleccionado = nuevoAuto;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione un auto';
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
      floatingActionButton: FloatingActionButton(
        onPressed: _irAgregarAuto,
        child: Icon(Icons.add),
        tooltip: 'Agregar Auto',
      ),
    );
  }
}
