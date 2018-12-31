import 'dart:convert';

import 'package:flutter/material.dart';

import 'API.dart';
import 'animal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var animals = new List<Animal>();

  _getUsers() {
    API.getAnimals().then((response) {
      setState(() {
        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON
          animals = (json.decode(response.body) as List)
              .map((data) => new Animal.fromJson(data))
              .toList();
        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load animals');
        }
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
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
