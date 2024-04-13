import 'package:cineswipe/api/api.dart';
import 'package:cineswipe/models/location_provider.dart';
import 'package:cineswipe/widgets/searchbar.dart';
import 'package:cineswipe/widgets/custom_marker.dart';
import 'package:cineswipe/models/place_detail.dart';
import 'package:cineswipe/models/searchpredicition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';

class TheaterLocation extends StatefulWidget {
  const TheaterLocation({super.key});

  @override
  State<TheaterLocation> createState() => _TheaterLocationState();
}

class _TheaterLocationState extends State<TheaterLocation> {
  final Set<Marker> _markers = {};
  final List<MarkerData> _markerData = [];

  GoogleMapController? _mapController;

  final _searchController = TextEditingController();
  GooglePlacesAPI dataSource = GooglePlacesAPI();

  final CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  String selectedPlaceId = "";
  LatLng selectedPlaceLatLng = const LatLng(0, 0);

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
    return riverpod.Consumer(builder: (context, ref, child) {
      return Scaffold(
        body: Stack(alignment: AlignmentDirectional.topStart, children: [
          CustomGoogleMapMarkerBuilder(
            customMarkers: _markerData,
            builder: (BuildContext context, Set<Marker>? markers) {
              return GoogleMap(
                initialCameraPosition: _cameraPosition,
                markers: markers ?? {},
                compassEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onTap: (tapLocation) {
                  setState(() {
                    _markers.clear();
                    _markerData.clear();
                    selectedPlaceId = "";
                    _searchController.clear();
                  });
                },
              );
            },
          ),
          Column(
            children: [
              SafeArea(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all( Radius.circular(300))),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        hintText: "Search"),
                    onTap: () async {
                      final Predicition? result = await showSearch(
                          context: context,
                          delegate: PlaceSearch(_mapController));
                      if (result!.placeId != "" && result.description != "") {
                        searchLocation(result);
                        setSelectedPlace(result.placeId);
                        _searchController.text = result.description;
                      } else {
                        setSelectedPlace("");
                        _markers.clear();
                        _searchController.clear();
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ]),
      );
    });
  }

  void searchLocation(Predicition predicition) async {
    GooglePlacesAPI dataSource = GooglePlacesAPI();

    //Get Place by place Id
    PlaceDetail place =
        await dataSource.getPlaceDetailsById(predicition.placeId);

    //Animate camera to coordinates
    moveCameraToLocation(place.location);
    addMarkerAtLocation(place);

    setState(() {
      selectedPlaceId = predicition.placeId;
    });
  }

  void moveCameraToLocation(LatLng location) {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 14.0)));
  }

  void addMarkerAtLocation(PlaceDetail place) {
    _markerData.clear();
    MarkerData marker = MarkerData(
        marker: Marker(
            markerId: const MarkerId("Search"),
            position: place.location,
            onTap: () {
              setSelectedPlace(selectedPlaceId);
            }),
        child: const CustomMarker());

    setState(() {
      _markerData.add(marker);
    });
  }

  void setSelectedPlace(String placeId) async {
    GooglePlacesAPI googleSource = GooglePlacesAPI();
    PlaceDetail details = await googleSource.getPlaceDetailsById(placeId);

    setState(() {
      selectedPlaceId = placeId;
      if (selectedPlaceId.isNotEmpty) {
        showPlaceDetailSheet(details);
      }
    });
  }

  void showPlaceDetailSheet(PlaceDetail details) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${details.name}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}
