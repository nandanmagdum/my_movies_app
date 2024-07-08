import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitt_arv_movie_app/controllers/movie_controller.dart';
import 'package:mitt_arv_movie_app/models/movie_details_model.dart';
import 'package:mitt_arv_movie_app/models/top_movie_model.dart';

class MovieApiService {
  /// Rapid API for popular
  static const String base_url_popular = "https://imdb8.p.rapidapi.com/title/v2/get-popular";
  static const String api_key_popular =
      "004aa3fcbemsh2201930c338c58dp1e9642jsn0affd4c3906c";

  /// Rapid API for Top Rated
  static const String base_url_top_rated =
      "https://imdb-top-100-movies.p.rapidapi.com/";
  static const String api_key_top_rated =
      "95f65ebb73msh3eb809aec4391acp124bfcjsn68069ab9bf86";

  /// OMDB API
  static const String omdb_base_url = "http://www.omdbapi.com/?apikey=8c1e856";

  /// get all top rated movies
  static Future<List<TopRatedMovieModel>> getTopRatedMovies({String? sortBy}) async{
    final URI = Uri.parse(base_url_top_rated);
    print(base_url_top_rated);
    final response = await http.get(URI, headers: {
      "X-RapidAPI-Key": api_key_top_rated
    });
    final data = jsonDecode(response.body); // List<dynamic>
    // convert list<dynamic> to List<Map<String, dynamic>>
    List<Map<String, dynamic>> listmap = [];
    for(int i=0; i<data.length; i++)
    {
      listmap.add({
        "title" : data[i]['title'] as String,
        "image": data[i]['image'] as String,
        "rank": data[i]['rank'] as int,
        "rating": data[i]['rating'] as String,
        "year": data[i]['year'] as int,
        "imdbid": data[i]['imdbid'] as String
      });
    }
    // convert List<Map<String, dynamic>> to List<TopRatedMoviwModel>
    List<TopRatedMovieModel> topMovies = listmap.map((e) => TopRatedMovieModel.fromJson(e),).toList();
    switch (Get.find<MovieController>().sortBy.value) {
              case "null":
                break;
              case "title":
                topMovies.sort((a, b) => a.title.compareTo(b.title));
                break;
              case "rank":
                topMovies.sort((a, b) => a.rank.compareTo(b.rank));
                break;
              case "rating":
                topMovies.sort((a, b) => a.rating.compareTo(b.rating));
              case "year":
                topMovies.sort((a, b) => a.year.compareTo(b.year));
                break;
              default:
                break;
            }
    return topMovies;
  }

  /// get a movie from imdb id
  static Future<MovieDetailsModel> getMovieByImdbId({required String imdbID}) async{
    final URI = Uri.parse("http://www.omdbapi.com/?apikey=8c1e856&i=${imdbID}");
    final response = await http.get(URI);
    final data = jsonDecode(response.body);
    print(data);
    print(data.runtimeType);
    if(response.statusCode == 200)
    return MovieDetailsModel.fromJson(data);
    throw Exception(data);
  }
}
