import 'package:flutter/material.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image, fit: BoxFit.cover),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
