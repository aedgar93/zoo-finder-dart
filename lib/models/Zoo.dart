import 'package:zoo_finder/models/Animal.dart';

class Zoo {
  final String id;
  final List<Animal> fullAnimals;
  final List<dynamic> animalIds;
  final String name;
  final num lat;
  final num long;

  Zoo(
      {this.id,
      this.fullAnimals,
      this.animalIds,
      this.name,
      this.lat,
      this.long});

  factory Zoo.fromJson(Map<String, dynamic> results) {
    List<Animal> animalList = List();
    if (results['animal_objects'] != null) {
      animalList = results['animal_objects']
          .map<Animal>((data) => new Zoo.fromJson(data))
          .toList();
    }
    return Zoo(
      id: results['id'],
      fullAnimals: animalList,
      animalIds: results['animals'],
      name: results['name'],
      lat: results['location'][0],
      long: results['location'][1],
    );
  }
}
