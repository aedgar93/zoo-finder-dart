import 'package:flutter/material.dart';
import 'package:zoo_finder/models/Animal.dart';
import 'package:zoo_finder/services/API.dart';
import 'package:zoo_finder/services/repo.dart';

import 'AnimalScreen.dart';

class AnimalListScreen extends StatefulWidget {
  final AnimalRepository animalRepository;

  AnimalListScreen({@required this.animalRepository});

  @override
  createState() =>
      _AnimalListScreenState(animalRepository: this.animalRepository);
}

class _AnimalListScreenState extends State {
  var animals = new List<Animal>();
  final AnimalRepository animalRepository;

  _AnimalListScreenState({@required this.animalRepository});

  _getAnimals() {
    //TODO: fix repo
//    animalRepository.getAnimals().then((fetchAnimals) {
//      animals = fetchAnimals;
//    });
    API.getAnimals().then((fetchAnimals) {
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
            return ListTile(
              title: Text(animals[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalScreen(animal: animals[index]),
                  ),
                );
              },
            );
          },
        ));
  }
}
