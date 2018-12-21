import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp(animals: fetchAnimals()));

class MyApp extends StatelessWidget {
  final Future<List<Animal>> animals;

  MyApp({Key key, this.animals}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Show me the Otters!',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Animal>>(
            future: animals,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("All Animals ${snapshot.data.length}");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Animal>> fetchAnimals() async {
  final response = await http.get('http://localhost:5000/api/animals');

  if (response.statusCode == 200) {
    List<Animal> animalList = List();
    // If the call to the server was successful, parse the JSON
    animalList = (json.decode(response.body) as List)
        .map((data) => new Animal.fromJson(data))
        .toList();

    return animalList;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load animals');
  }
}

class Zoo {
  final String id;
  final List<dynamic> fullAnimals;
  final List<dynamic> animalIds;
  final String name;

  Zoo({this.id, this.fullAnimals, this.animalIds, this.name});

  factory Zoo.fromJson(Map<String, dynamic> json) {
    return Zoo(
      id: json['id'],
      fullAnimals: json['animal_objects'],
      animalIds: json['animals'],
      name: json['name'],
    );
  }
}

class Animal {
  final String id;
  final List<dynamic> zooIds;
  final List<Zoo> fullZoos;
  final String name;

  Animal({this.id, this.zooIds, this.fullZoos, this.name});

  factory Animal.fromJson(Map<String, dynamic> results) {
    List<Zoo> zooList = List();
    zooList = results['zoo_objects']
        .map<Zoo>((data) => new Zoo.fromJson(data))
        .toList();
    return Animal(
      id: results['id'],
      zooIds: results['zoos'],
      fullZoos: zooList,
      name: results['name'],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
