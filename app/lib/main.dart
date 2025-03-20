import 'package:flutter/material.dart';
import 'package:app/swiper.dart';

void main() {
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: Swiper(),
    );
  }
}

