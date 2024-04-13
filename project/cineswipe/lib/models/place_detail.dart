import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:json_annotation/json_annotation.dart";

@JsonSerializable()
class PlaceDetail {
  final Object? name;
  final LatLng location;

  PlaceDetail(
    this.name,
    this.location,
  );

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceFromJson(json);
}


PlaceDetail _$PlaceFromJson(Map<String, dynamic> json) => PlaceDetail(
      json['name'],
      locationFromJson(json['geometry']['location'] as Map<String, dynamic>),
    );

LatLng locationFromJson(Map<String,dynamic> json) {
  LatLng coords = LatLng(
    json['lat'], 
    json['lng']);
  return coords;
}