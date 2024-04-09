import 'package:cineswipe/api/api.dart';
import 'package:cineswipe/models/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TheaterLocation extends StatefulWidget {
  const TheaterLocation({super.key});

  @override
  State<TheaterLocation> createState() => _TheaterLocationState();
}

class _TheaterLocationState extends State<TheaterLocation> {
  GoogleMapController? _mapController;

  final _searchController = TextEditingController();
  GooglePlacesAPI dataSource = GooglePlacesAPI();

  final CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  @override
  void initState() {
    UserPosition datasource = UserPosition();
    final initialPosition = datasource.getUserPosition();

    initialPosition.then((currentLocation) => {
          _mapController!.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 14.0))),
        });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: GoogleMap(
          initialCameraPosition: _cameraPosition,
          compassEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onTap: (tapLocation) {},
        ));
      }
  }
