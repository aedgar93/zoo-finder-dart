library repos;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:zoo_finder/models/Animal.dart';
import 'package:zoo_finder/services/API.dart';

class AnimalRepository {
  List<Animal> allAnimals;

  bool animalsLoaded = false;
  final completers = new HashMap<int, Set<Completer>>();
  final Set<Completer> allCompleters = new LinkedHashSet<Completer>();

  AnimalRepository({this.allAnimals});

  Future<Animal> getAnimal(int index) {
    if (this.animalsLoaded) {
      return getAnimalFromList(index);
    } else {
      var future = API.getAnimals();
      future.asStream().listen(onData);
      return buildFuture(index);
    }
  }

  Future<List<Animal>> getAnimals() {
    if (this.animalsLoaded) {
      var completer = Completer<List<Animal>>();
      completer.complete(this.allAnimals);
      return completer.future;
      ;
    } else {
      API.getAnimals().then(onData);
      return buildFutureAll();
    }
  }

  Future<Animal> buildFuture(int index) {
    var completer = Completer<Animal>();

    if (this.completers[index] == null) {
      this.completers[index] = Set<Completer>();
    }
    this.completers[index].add(completer);

    return completer.future;
  }

  Future<List<Animal>> buildFutureAll() {
    var completer = Completer<List<Animal>>();
    this.allCompleters.add(completer);
    return completer.future;
  }

  Future<Animal> getAnimalFromList(int index) async {
    return this.allAnimals.elementAt(index);
  }

  void onData(response) {
    if (response.statusCode == 200) {
      this.animalsLoaded = true;
      this.allAnimals = (json.decode(response.body) as List)
          .map((data) => new Animal.fromJson(data))
          .toList();
      this.allAnimals.sort((Animal a, Animal b) => a.name.compareTo(b.name));

      //resolve completers waiting for all animals
      this.allCompleters.forEach((completer) {
        completer.complete(this.allAnimals);
      });
      this.allCompleters.clear();

      //resolve completers waiting for single animal
      this.allAnimals.asMap().forEach((index, animal) {
        Set<Completer> comps = this.completers[index];

        if (comps != null) {
          for (var completer in comps) {
            completer.complete(animal);
          }
          comps.clear();
        }
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load animals');
    }
  }
}

var animalRepo = new AnimalRepository();
