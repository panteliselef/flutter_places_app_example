import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/helper/location_helper.dart';
import '../models/place.dart';
import 'package:places_app/helper/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final updateLocation = PlaceLocation(
        address: address,
        latitude: location.latitude,
        longitude: location.longitude);
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: updateLocation,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'imagePath': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBHelper.getData('user_places');
    print('Fetching. ...');
    _places = datalist.map((item) {
      print('Image: ${item['imagePath']}');
      return Place(
        id: item['id'],
        title: item['title'],
        image: File(item['imagePath']),
        location: PlaceLocation(
          longitude: item['loc_lng'],
          latitude: item['loc_lat'],
          address: item['address'],
        ),
      );
    }).toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }
}
