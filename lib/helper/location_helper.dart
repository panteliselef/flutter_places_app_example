import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:places_app/helper/secret_loader.dart';
import 'package:places_app/models/secret.dart';

// const GOOGLE_API_KEY = 'AIzaSyBdrh7gLrvxbSiVTd272_r1Pr3Muunvcpk';

class LocationHelper {
  static Future<String> _getApiKey() async {
    Secret secret =
        await SecretLoader(secretPath: "assets/secrets.json").load();
    return secret.apiKey;
  }

  static Future<String> generateLocationPreviewImage(
      {double latitude, double longitude}) async {
    var apiKey = await _getApiKey();
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$apiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    var apiKey = await _getApiKey();
    final response = await http.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
