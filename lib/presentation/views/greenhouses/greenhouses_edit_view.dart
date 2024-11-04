import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GreenhousesEditView extends StatefulWidget {
  const GreenhousesEditView({super.key});

  @override
  _GreenhousesEditViewState createState() => _GreenhousesEditViewState();
}

class _GreenhousesEditViewState extends State<GreenhousesEditView> {
  final DatabaseReference _invernaderoRef =
      FirebaseDatabase.instance.ref().child('greenhouses/greenhouse_1/details');

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final dataSnapshot = await _invernaderoRef.get();
    final data = dataSnapshot.value as Map?;
    setState(() {
      _nameController.text = data?['name'] ?? '';
      _locationController.text = data?['location'] ?? '';
      _sizeController.text = data?['size'].toString() ?? '';
      _statusController.text = data?['status'] ?? '';
    });
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      _invernaderoRef.update({
        'name': _nameController.text,
        'location': _locationController.text,
        'size': int.tryParse(_sizeController.text) ?? 0,
        'status': _statusController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos actualizados correctamente')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar datos: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDITAR'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la vista anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
                validator: (value) => value!.isEmpty ? 'Ingrese una ubicación' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sizeController,
                decoration: const InputDecoration(labelText: 'Tamaño (m²)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Ingrese el tamaño' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) => value!.isEmpty ? 'Ingrese el estado' : null,
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _saveData,
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _sizeController.dispose();
    _statusController.dispose();
    super.dispose();
  }
}
