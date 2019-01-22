//library repos;
//
//import 'dart:async';
//import 'dart:collection';
//import 'dart:convert';
//
//import 'package:http/http.dart';
//import 'package:zoo_finder/models/Animal.dart';
//import 'package:zoo_finder/models/Zoo.dart';
//import 'package:zoo_finder/services/API.dart';
//
//abstract class Repository {
//  bool hasLoaded = false;
//  final completers = new HashMap<int, Set<Completer>>();
//  final Set<Completer> allCompleters = new LinkedHashSet<Completer>();
//
//  Repository();
//
//  List decodeData(Response response);
//
//  Future getFromAPI();
//
//  void setItems(items);
//
//  void onData(response) {
//    if (response.statusCode == 200) {
//      this.hasLoaded = true;
//      var items = decodeData(response);
//      setItems(items);
//      //resolve completers waiting for all items
//      this.allCompleters.forEach((completer) {
//        completer.complete(items);
//      });
//      this.allCompleters.clear();
//
//      //resolve completers waiting for single item
//      items.asMap().forEach((index, item) {
//        Set<Completer> comps = this.completers[index];
//
//        if (comps != null) {
//          for (var completer in comps) {
//            completer.complete(item);
//          }
//          comps.clear();
//        }
//      });
//    } else {
//      // If that call was not successful, throw an error.
//      throw Exception('Failed to load animals');
//    }
//  }
//}
//
//class AnimalRepository extends Repository {
//  List<Animal> allAnimals;
//  List decodeData(response) {
//    return (json.decode(response.body) as List)
//        .map((data) => new Animal.fromMap(data))
//        .toList();
//  }
//
//  @override
//  Future getFromAPI() {
//    return API.getAnimals();
//  }
//
//  Future<List<Animal>> buildFutureAll() {
//    var completer = Completer<List<Animal>>();
//    this.allCompleters.add(completer);
//    return completer.future;
//  }
//
//  Future<List<Animal>> getAnimals() {
//    if (this.hasLoaded) {
//      var completer = Completer<List<Animal>>();
//      completer.complete(this.allAnimals);
//      return completer.future;
//    } else {
//      getFromAPI().then((result) {
//        onData(result);
//      });
//      return buildFutureAll();
//    }
//  }
//
//  Future<Animal> getAnimalFromList(int index) async {
//    return this.allAnimals.elementAt(index);
//  }
//
//  Future<Animal> getAnimal(int index) {
//    if (this.hasLoaded) {
//      return getAnimalFromList(index);
//    } else {
//      var future = getFromAPI();
//      future.asStream().listen((result) {
//        onData(result);
//      });
//      return buildFuture(index);
//    }
//  }
//
//  Future<Animal> buildFuture(int index) {
//    var completer = Completer<Animal>();
//
//    if (this.completers[index] == null) {
//      this.completers[index] = Set<Completer>();
//    }
//    this.completers[index].add(completer);
//
//    return completer.future;
//  }
//
//  void setItems(items) {
//    this.allAnimals = items;
//  }
//}
//
//class ZooRepository extends Repository {
//  List<Zoo> allZoos;
//  List decodeData(response) {
//    return (json.decode(response.body) as List)
//        .map((data) => new Zoo.fromMap(data))
//        .toList();
//  }
//
//  Future<Zoo> getZooFromList(int index) async {
//    return this.allZoos.elementAt(index);
//  }
//
//  Future<Zoo> getZoo(int index) {
//    if (this.hasLoaded) {
//      return getZooFromList(index);
//    } else {
//      var future = getFromAPI();
//      future.asStream().listen((result) {
//        onData(result);
//      });
//      return buildFuture(index);
//    }
//  }
//
//  Future<List<Zoo>> buildFutureAll() {
//    var completer = Completer<List<Zoo>>();
//    this.allCompleters.add(completer);
//    return completer.future;
//  }
//
//  Future<Zoo> buildFuture(int index) {
//    var completer = Completer<Zoo>();
//
//    if (this.completers[index] == null) {
//      this.completers[index] = Set<Completer>();
//    }
//    this.completers[index].add(completer);
//
//    return completer.future;
//  }
//
//  @override
//  Future getFromAPI() {
//    return API.getZoos();
//  }
//
//  Future<List<Zoo>> getZoos() {
//    if (this.hasLoaded) {
//      var completer = Completer<List<Zoo>>();
//      completer.complete(this.allZoos);
//      return completer.future;
//    } else {
//      getFromAPI().then((result) {
//        onData(result);
//      });
//      return buildFutureAll();
//    }
//  }
//
//  void setItems(items) {
//    this.allZoos = items;
//  }
//}
//
//var animalRepo = new AnimalRepository();
//var zooRepo = new ZooRepository();
