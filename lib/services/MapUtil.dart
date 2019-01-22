//import 'package:map_view/map_view.dart';
//
//import '../models/Animal.dart';
//import '../models/Zoo.dart';
//
//class MapUtil {
//  static var apiKey = "AIzaSyBjByGoFxzMxHJMGJhR30L6NFSXkg99odo";
//  var staticMapProvider;
//
//  init() {
//    staticMapProvider = new StaticMapProvider(MapUtil.apiKey);
//  }
//
//  List<Marker> getMarkers(List<Zoo> zoos) {
//    List<Marker> markers = new List<Marker>();
//    zoos.forEach((zoo) {
//      Marker marker = new Marker('testid', zoo.name, zoo.lat, zoo.long);
//      markers.add(marker);
//    });
//    return markers;
//  }
//
//  String getStaticMap(Animal animal) {
//    Uri staticMapUri = staticMapProvider.getStaticUriWithMarkersAndZoom(
//        getMarkers(animal.zoos),
//        height: 400,
//        width: 900);
//    String uriString = staticMapUri.toString();
//    if (animal.zoos.length == 1) {
//      //zoom is broken. add it manually
//      uriString += "&zoom=5";
//    }
//    return uriString;
//  }
//
//  showMap(MapView mapView, Animal animal) {
//    MapView.setApiKey(apiKey);
//    mapView.show(
//        new MapOptions(
//            mapViewType: MapViewType.normal,
//            showUserLocation: true,
//            title: "Show me the ${animal.name}s!"),
//        toolbarActions: [new ToolbarAction("Close", 1)]);
//
//    mapView.onMapReady.listen((_) {
//      mapView.setMarkers(getMarkers(animal.zoos));
//      mapView.zoomToFit(padding: 100);
//    });
//
//    mapView.onToolbarAction.listen((id) {
//      if (id == 1) {
//        mapView.dismiss();
//      }
//    });
//  }
//}
