import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:zoo_finder/models/Animal.dart';
import 'package:zoo_finder/services/MapUtil.dart';

class AnimalScreen extends StatefulWidget {
  final Animal animal;

  AnimalScreen({@required this.animal});

  @override
  createState() => _AnimalScreenState(animal: this.animal);
}

class _AnimalScreenState extends State<AnimalScreen> {
  final teLatitude = TextEditingController();
  final teLongitude = TextEditingController();
  final teZoomLevel = TextEditingController();
  MapView mapView;
  MapUtil mapUtil;
  final Animal animal;

  _AnimalScreenState({@required this.animal});

  @override
  void initState() {
    super.initState();

    mapUtil = new MapUtil();
    mapUtil.init();
    mapView = new MapView();
    teLatitude.text = mapUtil.getCamera().center.latitude.toString();
    teLongitude.text = mapUtil.getCamera().center.longitude.toString();
    teZoomLevel.text = mapUtil.getCamera().zoom.toString();
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
                  child: new Image.network(mapUtil.getStaticMap().toString()),
                ),
              ),
            ],
          ),
        ),
        new Container(
          height: 150,
          child: new Text(
            "You can find ${animal.name}s at these zoos:",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        new Expanded(
          child: ListView.builder(
            itemCount: animal.fullZoos.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(animal.fullZoos[index].name));
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
