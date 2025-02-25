import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class HomeProvider extends ChangeNotifier {
  final List<List<dynamic>> _places = [
    [
      'Kangaru',
      'The market place',
    ]
  ];

  List<List<dynamic>> get places => _places;

  void addPlace(String name, String description) {
    _places.add([name, description]);
    notifyListeners(); // Notify listeners that the data has changed
  }

  List<Marker> markers = [];
  List<Marker> get _markers => markers;

  List<String> comments = [];
  List<String> get _comments => comments;
}
