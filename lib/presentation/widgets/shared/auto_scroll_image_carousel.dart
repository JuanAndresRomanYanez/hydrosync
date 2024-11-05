import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Actualiza el índice actual
              });
            },
          ),
          items: widget.imagePaths.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10), // Espacio entre el carrusel y el contador
        Text(
          'Imagen ${_currentIndex + 1} de ${widget.imagePaths.length}', // Contador
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
