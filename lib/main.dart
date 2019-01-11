import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import 'screens/AnimalListScreen.dart';

void main() {
  MapView.setApiKey("AIzaSyBjByGoFxzMxHJMGJhR30L6NFSXkg99odo");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Show me the Otters!',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AnimalListScreen(),
    );
  }
}
