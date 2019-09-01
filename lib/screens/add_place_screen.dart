import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat,double lng){
    setState(() {
      _pickedLocation = PlaceLocation(latitude: lat,longitude: lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                height: 50,
                color: Theme.of(context).accentColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.save,
                      size: 24,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Save Place',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: _savePlace,
            ),
//            RaisedButton.icon(
//              elevation: 0,
//              label: Text('Add Place'),
//              icon: Icon(Icons.add),
//              onPressed: _savePlace,
//              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//            ),
          ],
        ),
      ),
    );
  }
}
