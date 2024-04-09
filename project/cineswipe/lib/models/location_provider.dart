import 'package:cineswipe/api/api.dart';
import 'package:cineswipe/models/prediction.dart';
import 'package:cineswipe/models/user_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

//Location data source providers for the repository
final userLocationDataSourceProvider = Provider((ref) => UserPosition());
final googlePlacesDataSourceProvider = Provider((ref) => GooglePlacesAPI());

//Provides an instance of the user location repository
final userLocationRepositoryProvider = Provider<UserLocationRepository>((ref){
  final dataSource = ref.watch(userLocationDataSourceProvider);
  final googlePlacesDataSource = ref.watch(googlePlacesDataSourceProvider);
  final repository = UserLocationRepository(dataSource, googlePlacesDataSource);

  return repository;
});

final positionProvider = FutureProvider<Position>((ref) async {
  final repository = ref.watch(userLocationRepositoryProvider);

  return await repository.getUserPosition();
});

//Provides a stream of Position objects defining the user's curerent location
final userPositionProvider = StreamProvider.autoDispose<Position?>((ref) {
  final streamController = StreamController<Position?>();

  final repository = ref.watch(userLocationRepositoryProvider);
  repository.getUserPositionStream(streamController);

  return streamController.stream;
});

//Provides a stream of UserLocation objects defining the user's current location
final locationProvider = StreamProvider.autoDispose<UserLocation?>((ref) {
  final repository = ref.watch(userLocationRepositoryProvider);

  final positionStreamController = StreamController<Position?>();
  final locationStreamController = StreamController<UserLocation?>();
  repository.getUserPositionStream(positionStreamController);

  positionStreamController.stream.listen((position) {
    UserLocation location = UserLocation(
      position: position
    );

    void getPlaces() async{
      locationStreamController.add(location);
    }
  });

  return locationStreamController.stream;
});

class UserLocationRepository{
  UserLocationRepository(this.dataSource, this.placesDataSource);

  final UserPosition dataSource;
  final GooglePlacesAPI placesDataSource;

  Future<Position> getUserPosition() {
    return dataSource.getUserPosition();
  }

  void getUserPositionStream(StreamController<Position?> streamController) {
    return dataSource.getUserPositionStream(streamController);
  }

  Future<dynamic> getPlaceDetailsById(String placeId) {
    return getPlaceDetailsById(placeId);
  }

  Future<Predicition> fetchPredictions(String input){
    return fetchPredictions(input);
  }

}

class UserPosition {

  //Get UserLocation object using position and return
  Future<Position> getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  //Get the position stream from geolocator and pass into a stream controller
  void getUserPositionStream(StreamController<Position?> streamController) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream(locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5
    )).listen((Position position) {   
        streamController.add(position);
      });
  }
}
