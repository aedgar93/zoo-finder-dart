import 'package:cloud_firestore/cloud_firestore.dart';

class Zoo {
  final List<DocumentReference> animals;
  final String name;
  final num lat;
  final num long;
  final DocumentReference reference;

  Zoo({this.animals, this.name, this.lat, this.long, this.reference});

  factory Zoo.fromSnapshot(DocumentSnapshot snapshot) {
    return Zoo.fromMap(snapshot.data, snapshot.reference);
  }

  factory Zoo.fromMap(Map<String, dynamic> results, DocumentReference ref) {
    return Zoo(
      animals: results['animals'],
      name: results['name'],
      lat: results['location'] != null ? results['location'][0] : null,
      long: results['location'] != null ? results['location'][1] : null,
      reference: ref,
    );
  }
}
