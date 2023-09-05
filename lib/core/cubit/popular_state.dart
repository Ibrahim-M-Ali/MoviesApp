// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/now_movies_response.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularLoadingAction());

  void loadPopularMovies(int page) async {
    try {
      var response = await ApiServices.getPopularMovies(page);
      if (response.results == 401) {
        emit(PopularFailureAction('No Internet Connection'));
      } else {
        emit(PopularSuccessAction(
            results: response.results,
            pageNumber: response.page,
            totalPages: response.totalPages));
      }
    } catch (e) {
      emit(PopularFailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class PopularMoviesState {}

class PopularLoadingAction extends PopularMoviesState {}

class PopularFailureAction extends PopularMoviesState {
  String? errorMessage;
  PopularFailureAction(
    this.errorMessage,
  );
}

class PopularSuccessAction extends PopularMoviesState {
  List<Results>? results;
  int? pageNumber;
  int? totalPages;
  PopularSuccessAction({
    this.results,
    this.pageNumber,
    this.totalPages,
  });
}
