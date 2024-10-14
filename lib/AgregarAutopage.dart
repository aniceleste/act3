import 'package:flutter/material.dart';
import 'Auto.dart';

class AgregarAutoPage extends StatefulWidget {
  final List<Auto> autos; 

  AgregarAutoPage({required this.autos});

  @override
  _AgregarAutoPageState createState() => _AgregarAutoPageState();
}

class _AgregarAutoPageState extends State<AgregarAutoPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _consumoController = TextEditingController();

  void _agregarAuto() {
    String nombre = _nombreController.text;
    double consumo = double.parse(_consumoController.text);

    if (nombre.isNotEmpty && consumo > 0) {
      Auto nuevoAuto = Auto(nombre: nombre, consumoPorKm: consumo);
      widget.autos.add(nuevoAuto);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Auto agregado correctamente')));
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Auto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Auto'),
            ),
            TextField(
              controller: _consumoController,
              decoration: InputDecoration(labelText: 'Consumo por Km (litros/km)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarAuto,
              child: Text('Agregar Auto'),
            ),
          ],
        ),
      ),
    );
  }
}
