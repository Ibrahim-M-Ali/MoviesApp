import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/genersResponse.dart';

class TvGenresCubit extends Cubit<TvGenresState> {
  TvGenresCubit() : super(LoadingAction());

  void loadTvGenres(int tvID) async {
    try {
      var response = await ApiServices.getTvGeneres(tvID);
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

abstract class TvGenresState {}

class LoadingAction extends TvGenresState {}

class FailureAction extends TvGenresState {
  String? errorMessage;
  FailureAction(
    this.errorMessage,
  );
}

class SuccessAction extends TvGenresState {
  List<GenresRes>? results;
  SuccessAction({
    this.results,
  });
}
