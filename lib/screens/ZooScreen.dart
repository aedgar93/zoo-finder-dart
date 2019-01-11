import 'package:flutter/material.dart';
import 'package:zoo_finder/models/Zoo.dart';

class ZooScreen extends StatefulWidget {
  final Zoo zoo;

  ZooScreen({@required this.zoo});

  @override
  createState() => _ZooScreenState(zoo: this.zoo);
}

class _ZooScreenState extends State<ZooScreen> {
//  MapView mapView;
//  MapUtil mapUtil;
//  String staticMap;
  final Zoo zoo;

  _ZooScreenState({@required this.zoo});

  @override
  void initState() {
    super.initState();

//    mapUtil = new MapUtil();
//    mapUtil.init();
//    mapView = new MapView();
//    staticMap = mapUtil.getStaticMap(zoo);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 230.0,
          child: Text("${zoo.name}"),
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "${zoo.name}",
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
