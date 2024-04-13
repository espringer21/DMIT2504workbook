class Predicition{
  final String placeId;
  final String description;

  Predicition(this.placeId, this.description);

  factory Predicition.fromJson(Map<String, dynamic> json) => 
    _$PredicitionFromJson(json);
}

Predicition _$PredicitionFromJson(Map<String, dynamic> json) => Predicition(
  json['place_id'],
  json['description']
);
