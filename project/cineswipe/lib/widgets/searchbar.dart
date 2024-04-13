import 'package:cineswipe/api/api.dart';
import 'package:cineswipe/models/location_provider.dart';
import 'package:cineswipe/models/place_detail.dart';
import 'package:cineswipe/models/searchpredicition.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSearch extends SearchDelegate<Predicition> {
  GoogleMapController? _controller;
  PlaceSearch(this._controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        close(context, Predicition('',''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    UserPosition datasource = UserPosition();
    final _position = datasource.getUserPosition();

    return FutureBuilder<List<Predicition>>(
      future: fetchPredictions(query), 
      builder: (context, snapshot) => query == ''
        ? Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text('')
        )
        : snapshot.hasData
          ? ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title:
                Text(snapshot.data![index].description),
              onTap: () {
                userSearchLocation(_controller, snapshot.data![index]);

                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                close(context, snapshot.data![index]);
              },
            ),
            itemCount: snapshot.data!.length,
          )
          : const Text("loading...")
      );
  }
}
void userSearchLocation(
      GoogleMapController? controller, Predicition predicition) async {
      GooglePlacesAPI dataSource = GooglePlacesAPI();

    //Get Place by place Id
    PlaceDetail place =
        await dataSource.getPlaceDetailsById(predicition.placeId);

    //Animate camera to coordinates
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(place.location.latitude, place.location.longitude),
        zoom: 14.0)));
}