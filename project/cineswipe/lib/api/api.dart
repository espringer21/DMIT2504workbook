import 'package:cineswipe/models/user_location_provider.dart';
import 'package:cineswipe/models/constants.dart';
import 'package:cineswipe/models/movie.dart';
import 'package:cineswipe/models/place_detail.dart';
import 'package:cineswipe/models/prediction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Class to retrieve data from TMDB API
class MovieApi{
  static const _trendingUrl = '${Constants.moviebaseURL}/trending/movie/day?api_key=${Constants.movieApiKey}';
  static const _topRatedUrl = '${Constants.moviebaseURL}/movie/top_rated?api_key=${Constants.movieApiKey}';
  static const _upcomingUrl = '${Constants.moviebaseURL}/movie/upcoming?api_key=${Constants.movieApiKey}';
  //Gets Trending movies from api
  Future<List<Movie>> getTrendingMovies() async{

    final response = await http.get(Uri.parse(_trendingUrl));

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Nothing was returned');
    }
  }
  //Gets Top rated movies from api
  Future<List<Movie>> getTopRatedMovies() async{

    final response = await http.get(Uri.parse(_topRatedUrl));

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Nothing was returned');
    }
  }
  //Gets Upcoming movies from api
  Future<List<Movie>> getUpcomingMovies() async{

    final response = await http.get(Uri.parse(_upcomingUrl));

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Nothing was returned');
    }
  }
}
//Class to get data from Google Places API
class GooglePlacesAPI {

    //Gets PlaceDetails response from google places api by place_id
    Future<PlaceDetail> getPlaceDetailsById(String placeId) async {
      var url = Uri.parse('${Constants.googleMapsbaseURL}/details/json?').replace(queryParameters: {
        'place_id': placeId,
        'fields': 'geometry,formatted_address,formatted_phone_number,name,types,opening_hours',
        'key': Constants.googleMapAPIKEY
      });

      var response = await http.post(url);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      PlaceDetail detail = PlaceDetail.fromJson(data['result']);
      return detail;
    }
}
//fetch list of place predictions based on users text input
Future<List<Predicition>> fetchPredictions(String input) async {
  UserPositionDataSource positionSource = UserPositionDataSource();
  Position pos = await positionSource.getUserPosition();

  final url = Uri.parse('${Constants.googleMapsbaseURL}/autocomplete/json?').replace(queryParameters: {
    'input': input,
    'location': '${pos.latitude.toString()},${pos.longitude.toString()}',
    'radius' : '500',
    'key': Constants.googleMapAPIKEY
  });

  final response = await http.post(url);

  if (response.statusCode == 200){
    final result = json.decode(response.body);
    if (result['status'] == "OK"){
      List<Predicition> predictions = result['predictions']
        .map<Predicition>((result) => Predicition.fromJson(result))
        .toList();
      
      return predictions;
    }
    if (result['status'] == 'ZERO_RESULTS'){
      return [];
    }

    throw Exception(result['error_message']);
  } else {
    throw Exception('Failed to fetch predictions');
  }
}
