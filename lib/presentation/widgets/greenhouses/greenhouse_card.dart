import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hydrosync/domain/entities/greenhouse.dart';
import 'package:hydrosync/presentation/widgets/widgets.dart';

class GreenhouseCard extends ConsumerWidget {
  final Greenhouse greenhouse;

  const GreenhouseCard({
    super.key, 
    required this.greenhouse
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xFF45C4DD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Text(
                greenhouse.details.name,
                textAlign: TextAlign.center, // Centrar el texto
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20), // Espacio entre el título y la información
            
            // Carrusel de imágenes
             // Carrusel de imágenes con desplazamiento automático
            if (greenhouse.crops.isNotEmpty)
              AutoScrollImageCarousel(
                imagePaths: greenhouse.crops.map((crop) => crop.image).toList(),
              ),

            const SizedBox(height: 20,),
            // Uso de `InformativeDataRow` para mostrar cada dato
            InformativeDataRow(
              label: 'Ubicación', 
              value: greenhouse.details.location
            ),
            InformativeDataRow(
              label: 'Tamaño', 
              value: greenhouse.details.size
            ),
            InformativeDataRow(
              label: 'Estado', 
              value: greenhouse.details.status
            ),

            const SizedBox(height: 20), // Espacio antes de los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  label: 'Ver más',
                  icon: Icons.visibility,
                  color: Colors.green,
                  onPressed: () {
                    context.push(
                      '/greenhouses/details',
                      extra: greenhouse,
                    );
                  },
                ),
                const SizedBox(width: 30),
                ActionButton(
                  label: 'Editar',
                  icon: Icons.edit,
                  color: Colors.orange,
                  onPressed: () {
                    context.push(
                      '/greenhouses/edit',
                      extra: greenhouse,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AutoScrollImageCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const AutoScrollImageCarousel({
    super.key,
    required this.imagePaths,
  });

  @override
  AutoScrollImageCarouselState createState() => AutoScrollImageCarouselState();
}

class AutoScrollImageCarouselState extends State<AutoScrollImageCarousel> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8); // Ajuste para dar efecto de carrusel.

    // Iniciar el temporizador para desplazar las páginas automáticamente
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeIn.transform(value) * 200,
                  width: Curves.easeIn.transform(value) * 300,
                  child: child,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                widget.imagePaths[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}