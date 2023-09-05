// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/now_movies_response.dart';

class NowMoviesCubit extends Cubit<NowMoviesState> {
  NowMoviesCubit() : super(LoadingAction());

  void loadNowMovies(int page) async {
    try {
      var response = await ApiServices.getNowMovies(page);
      if (response.results == 401) {
        emit(FailureAction('No Internet Connection'));
      } else {
        emit(SuccessAction(
            results: response.results,
            pageNumber: response.page,
            totalPages: response.totalPages));
      }
    } catch (e) {
      emit(FailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class NowMoviesState {}

class LoadingAction extends NowMoviesState {}

class FailureAction extends NowMoviesState {
  String? errorMessage;
  FailureAction(
    this.errorMessage,
  );
}

class SuccessAction extends NowMoviesState {
  List<Results>? results;
  int? pageNumber;
  int? totalPages;
  SuccessAction({
    this.results,
    this.pageNumber,
    this.totalPages,
  });
}
