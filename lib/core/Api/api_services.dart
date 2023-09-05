import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/actors_response.dart';
import '../models/genersResponse.dart';
import '../models/now_movies_response.dart';
import '../models/tv_cast_response.dart';
import '../models/tv_response.dart';
import '../models/video_response.dart';

class ApiServices {
  int? moiveID;

  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOTRhYjFlMDEyYTk5MzJkZmIwNDBjZDU5NzUzZDgxMCIsInN1YiI6IjY0NzdiY2U1Y2Y0YjhiMDBjM2QwN2U0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gFfFeRkncp5ZNToihz_0UYjxp4udtgSyfOCIG_-9vGk';
  static var headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $accessToken'
  };

  static Future<NowMoviesResponse> getNowMovies(int page) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=$page'),
      headers: headers,
    );

    return NowMoviesResponse.fromJson(jsonDecode(response.body));
  }

  static Future<NowMoviesResponse> getPopularMovies(int page) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?language=en-US&page=$page'),
        headers: headers);
    // print(NowMoviesResponse.fromJson(jsonDecode(response.body)));
    return NowMoviesResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ActorResponse> gotFullCast(int movieID) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieID/credits?language=en-US'),
        headers: headers);
    // print(NowMoviesResponse.fromJson(jsonDecode(response.body)));
    return ActorResponse.fromJson(jsonDecode(response.body));
  }

  static Future<TvResponse> getTvOnAir(page) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/on_the_air?language=en-US&page=$page'),
        headers: headers);

    print(response.body);
    return TvResponse.fromJson(jsonDecode(response.body));
  }

  static Future<TvCastResponse> gotTvCast(int tvID) async {
    http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/$tvID/credits?language=en-US'),
      headers: headers,
    );
    // print(NowMoviesResponse.fromJson(jsonDecode(response.body)));
    return TvCastResponse.fromJson(jsonDecode(response.body));
  }

  static Future<TvResponse> getTvPopular(int page) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=$page'),
        headers: headers);
    // print(NowMoviesResponse.fromJson(jsonDecode(response.body)));
    return TvResponse.fromJson(jsonDecode(response.body));
  }

  static Future<String?> getMovieVideo(movieID) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieID/videos?language=en-US'),
        headers: headers);
    MovieVideoResponse data =
        MovieVideoResponse.fromJson(jsonDecode(response.body));
    String? mykey;
    for (int i = 0; i < data.results!.length; i++) {
      if (data.results![i].type == "Trailer") {
        mykey = data.results![i].key;
      }
    }

    return mykey;
  }

  static Future<Genres> getMovieGeneres(int movieID) async {
    http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieID?language=en-US'),
      headers: headers,
    );
    var data = Genres.fromJson(jsonDecode(response.body));

    return data;
  }

  static Future<NowMoviesResponse> searchMovies(String movieName) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/search/movie?query=$movieName&include_adult=false&language=en-US&page=1'),
        headers: headers);
    var data = NowMoviesResponse.fromJson(jsonDecode(response.body));

    return data;
  }

  static Future<TvResponse> searchTv(String tvName) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/search/tv?query=$tvName&include_adult=false&language=en-US&page=1'),
        headers: headers);
    var data = TvResponse.fromJson(jsonDecode(response.body));

    return data;
  }

  static Future<Genres> getTvGeneres(int tvID) async {
    http.Response response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/tv/$tvID?language=en-US'),
        headers: headers);
    var data = Genres.fromJson(jsonDecode(response.body));

    return data;
  }
}
