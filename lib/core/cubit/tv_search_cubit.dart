// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/Api/api_services.dart';
import '../models/tv_response.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  TvSearchCubit() : super(LoadingAction());

  void searchTv(String tvName) async {
    try {
      var response = await ApiServices.searchTv(tvName);
      if (response.tvResults == 401) {
        emit(FailureAction('No Internet Connection'));
      } else {
        emit(SuccessAction(
          results: response.tvResults,
        ));
      }
    } catch (e) {
      emit(FailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class TvSearchState {}

class LoadingAction extends TvSearchState {}

class FailureAction extends TvSearchState {
  String? errorMessage;
  FailureAction(
    this.errorMessage,
  );
}

class SuccessAction extends TvSearchState {
  List<TvResults>? results;

  SuccessAction({
    this.results,
  });
}
