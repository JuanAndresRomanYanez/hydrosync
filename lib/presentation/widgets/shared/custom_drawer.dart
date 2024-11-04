import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Modo Día/Noche'),
              onTap: () {
                // Aquí puedes agregar la lógica para cambiar el modo
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            ListTile(
              title: const Text('Opción 2'),
              onTap: () {
                // Lógica para otra opción
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            // Agrega más opciones según sea necesario
          ],
        ),
      );
  }
}