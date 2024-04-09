import 'package:cineswipe/models/place.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  Position? position;
  double? lat;
  double? long;
  String? address;
  List<Place>? places;

  UserLocation({
    this.position, 
    this.lat, 
    this.long,
    this.address, 
    this.places
    });
}