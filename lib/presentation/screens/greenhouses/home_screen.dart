import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/presentation/providers/theme/theme_provider.dart';
import 'package:hydrosync/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:hydrosync/presentation/widgets/shared/custom_drawer.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home-screen';
  final StatefulNavigationShell currentChild;


  const HomeScreen({
    super.key,
    required this.currentChild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MALEN CULTIVOS HIDROPÓNICOS'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined ),
            onPressed: (){
              ref.read(themeNotifierProvider.notifier)
                 .toggleDarkMode();           
            }, 
          )
        ],
      ),
      body: currentChild,
      bottomNavigationBar: CustomBottomNavigation(
        currentChild: currentChild
      ),
      drawer: const CustomDrawer(),
    );
  }
}