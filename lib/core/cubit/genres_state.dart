import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/genersResponse.dart';

class MovieGenres extends Cubit<MovieGenresState> {
  MovieGenres() : super(LoadingAction());

  void loadMovieGenres(int movieID) async {
    try {
      var response = await ApiServices.getMovieGeneres(movieID);
      if (response.genres == 401) {
        emit(FailureAction('No Internet Connection'));
      } else {
        emit(SuccessAction(
          results: response.genres,
        ));
      }
    } catch (e) {
      emit(FailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class MovieGenresState {}

class LoadingAction extends MovieGenresState {}

class FailureAction extends MovieGenresState {
  String? errorMessage;
  FailureAction(
    this.errorMessage,
  );
}

class SuccessAction extends MovieGenresState {
  List<GenresRes>? results;
  SuccessAction({
    this.results,
  });
}
