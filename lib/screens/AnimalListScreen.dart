import 'package:flutter/material.dart';
import 'package:zoo_finder/models/Animal.dart';
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
  final animals = new List<Animal>();
  final animalsToDisplay = new List<Animal>();
  final AnimalRepository animalRepository;

  _AnimalListScreenState({@required this.animalRepository});
  TextEditingController editingController = TextEditingController();

  _getAnimals() {
    animalRepository.getAnimals().then((responseList) {
      setState(() {
        animals.addAll(responseList);
        animals.sort((Animal a, Animal b) => a.name.compareTo(b.name));
        animalsToDisplay.addAll(animals);
      });
    });
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      query = query.toLowerCase();
      List<Animal> listData = List<Animal>();
      animals.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          listData.add(item);
        }
      });
      setState(() {
        animalsToDisplay.clear();
        animalsToDisplay.addAll(listData);
      });
      return;
    } else {
      setState(() {
        animalsToDisplay.clear();
        animalsToDisplay.addAll(animals);
      });
    }
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: animalsToDisplay.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(animalsToDisplay[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnimalScreen(animal: animalsToDisplay[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
