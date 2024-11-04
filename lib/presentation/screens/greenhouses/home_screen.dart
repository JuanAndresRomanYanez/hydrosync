import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:hydrosync/presentation/widgets/shared/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final StatefulNavigationShell currentChild;


  const HomeScreen({
    super.key,
    required this.currentChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CULTIVOS HIDROPÓNICOS MALEN')),
      body: currentChild,
      bottomNavigationBar: CustomBottomNavigation(currentChild: currentChild),
      drawer: const CustomDrawer(),
    );
  }
}