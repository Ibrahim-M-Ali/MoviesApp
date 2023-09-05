// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/now_movies_response.dart';

class MoviesSearchCubit extends Cubit<MoviesSearchState> {
  MoviesSearchCubit() : super(LoadingAction());

  void searchMovies(String movieName) async {
    try {
      var response = await ApiServices.searchMovies(movieName);
      if (response.results == 401) {
        emit(FailureAction('No Internet Connection'));
      } else {
        emit(SuccessAction(
          results: response.results,
        ));
      }
    } catch (e) {
      emit(FailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class MoviesSearchState {}

class LoadingAction extends MoviesSearchState {}

class FailureAction extends MoviesSearchState {
  String? errorMessage;
  FailureAction(
    this.errorMessage,
  );
}

class SuccessAction extends MoviesSearchState {
  List<Results>? results;

  SuccessAction({
    this.results,
  });
}
