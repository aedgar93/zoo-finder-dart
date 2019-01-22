import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import '../models/Animal.dart';
import '../services/MapUtil.dart';

class AnimalScreen extends StatefulWidget {
  final Animal animal;

  AnimalScreen({@required this.animal});

  @override
  createState() => _AnimalScreenState(animal: this.animal);
}

class _AnimalScreenState extends State<AnimalScreen> {
  MapView mapView;
  MapUtil mapUtil;
  String staticMap;
  final Animal animal;

  _AnimalScreenState({@required this.animal});

  @override
  void initState() {
    super.initState();

    mapUtil = new MapUtil();
    mapUtil.init();
    mapView = new MapView();
    staticMap = mapUtil.getStaticMap(animal);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 230.0,
          child: new Stack(
            children: <Widget>[
              new GestureDetector(
                onTap: () => mapUtil.showMap(mapView, animal),
                child: new Center(
                  child: new Image.network(staticMap),
                ),
              ),
            ],
          ),
        ),
        new Container(
          height: 50,
          child: new Text(
            "You can find ${animal.name}s at these zoos:",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        new Expanded(
          child: ListView.builder(
            itemCount: animal.zoos.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(animal.zoos[index].name));
            },
          ),
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "${animal.name}",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: new Container(
        child: screenWidget,
      ),
    );
  }
}
