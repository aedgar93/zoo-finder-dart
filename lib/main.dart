import 'package:flutter/material.dart';
import 'package:zoo_finder/services/repo.dart';
import 'screens/AnimalListScreen.dart';

void main() => runApp(new MyApp());

final animalRepository = AnimalRepository();

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Show me the Otters!',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AnimalListScreen(animalRepository: animalRepository),
    );
  }
}
