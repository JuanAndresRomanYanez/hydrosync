import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final StatefulNavigationShell currentChild;

  const CustomBottomNavigation({
    super.key, 
    required this.currentChild
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      // fixedColor: const Color(0xff0000FF),
      // fixedColor: const Color(0xff0000FF),
      selectedItemColor: const Color(0xff0000FF),
      // unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed, // Asegura un comportamiento fijo
      currentIndex: currentChild.currentIndex,
      onTap: (idx) => currentChild.goBranch(idx),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'DASHBOARD',
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.local_florist ),
          label: 'INVERNADEROS',
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.insert_chart_outlined ),
          label: 'REPORTES',
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.health_and_safety ),
          label: 'SALUD',
        ),
      ],
    );
  }
}