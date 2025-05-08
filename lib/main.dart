import 'package:app/core.dart';
import 'package:app/presentation/swiper/screen.dart';
import 'package:app/screen.dart';
import 'package:flutter/material.dart';

void main() {
  setupServices();

  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaTinder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: AppScreen(screen: SwiperScreen()),
    );
  }
}
