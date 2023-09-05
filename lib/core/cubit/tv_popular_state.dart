// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/Api/api_services.dart';

import '../models/tv_response.dart';

class TvPopularCubit extends Cubit<TvPopularState> {
  TvPopularCubit() : super(TvPopularLoadingAction());

  void getTvPopular(page) async {
    var response = await ApiServices.getTvPopular(page);
    if (response.tvResults == 401) {
      emit(TvPopularFailureAction('No Internet Connection'));
    } else {
      emit(TvPopularSuccessAction(
          tvResults: response.tvResults,
          pageNumber: response.page,
          totalPages: response.totalPages));
    }
  }
}

abstract class TvPopularState {}

class TvPopularLoadingAction extends TvPopularState {}

class TvPopularFailureAction extends TvPopularState {
  String? errorMessage;
  TvPopularFailureAction(
    this.errorMessage,
  );
}

class TvPopularSuccessAction extends TvPopularState {
  List<TvResults>? tvResults;
  int? pageNumber;
  int? totalPages;
  TvPopularSuccessAction({this.tvResults, this.pageNumber, this.totalPages});
}
