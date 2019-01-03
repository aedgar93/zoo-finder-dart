import 'package:flutter/material.dart';
import 'package:zoo_finder/models/Animal.dart';

class AnimalScreen extends StatelessWidget {
  final Animal animal;

  AnimalScreen({Key key, @required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${animal.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('${animal.name}'),
      ),
    );
  }
}
