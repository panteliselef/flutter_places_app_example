import 'package:flutter/material.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: const Text('Got no places yet'),
                ),
                builder: (ctx, places, child) => places.places.length <= 0
                    ? child
                    : ListView.builder(
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(places.places[index].image),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(places.places[index].title),
                          subtitle: Text(places.places[index].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: places.places[index].id,
                            );
                          },
                        ),
                        itemCount: places.places.length,
                      ),
              ),
      ),
    );
  }
}
