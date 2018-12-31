import 'package:flutter/material.dart';

import 'animal.dart';
import 'repo.dart';

void main() => runApp(new MyApp());

final animalRepo = AnimalRepository();

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimalListScreen(),
    );
  }
}

class AnimalListScreen extends StatefulWidget {
  @override
  createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State {
  var animals = new List<Animal>();

  _getAnimals() {
    animalRepo.getAnimals().then((fetchAnimals) {
      animals = fetchAnimals;
    });
  }

  initState() {
    super.initState();
    _getAnimals();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animal List"),
        ),
        body: ListView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(animals[index].name));
          },
        ));
  }
}
