import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:json_annotation/json_annotation.dart";

@JsonSerializable()
class Place {
  final String? placeId;
  final Object? name;
  final LatLng? position;
  final List<String>? types;
  final List<LatLng>? geometry;

  Place(
    this.placeId,
    this.name,
    this.position,
    this.types,
    this.geometry
  );

  factory Place.fromJson(Map<String, dynamic> json) =>
      _$PlaceFromJson(json);
}


Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      json['place_id'] as String?,
      json['name'],
      (getPlaceLocation(json['geometry']['location'])),
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (getGeometry(json['geometry']['viewport']))
    );

LatLng getPlaceLocation(Map<String, dynamic> locationMap){
  LatLng coords = LatLng(
    locationMap['lat'], 
    locationMap['lng']);
  return coords;
}

List<LatLng> getGeometry(Map<String, dynamic> geometryMap) {
  List<LatLng> coordsList = List.empty(growable: true);
  geometryMap.values.forEach((coord) {
    coordsList.add(LatLng(coord['lat'], coord['lng']));
  });

  return coordsList;
}

