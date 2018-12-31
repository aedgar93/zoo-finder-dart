import 'zoo.dart';

class Animal {
  final String id;
  final List<dynamic> zooIds;
  final List<Zoo> fullZoos;
  final String name;

  Animal({this.id, this.zooIds, this.fullZoos, this.name});

  factory Animal.fromJson(Map<String, dynamic> results) {
    List<Zoo> zooList = List();
    if (results['zoo_objects'].isEmpty) {
      zooList = results['zoo_objects']
          .map<Zoo>((data) => new Zoo.fromJson(data))
          .toList();
    }

    return Animal(
      id: results['id'],
      zooIds: results['zoos'],
      fullZoos: zooList,
      name: results['name'],
    );
  }
}
