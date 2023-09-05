// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/Api/api_services.dart';

import '../models/tv_cast_response.dart';

class TvCastCubit extends Cubit<TvCastState> {
  TvCastCubit() : super(TvCastLoadingAction());

  void getTvCast(tvID) async {
    try {
      var response = await ApiServices.gotTvCast(tvID);
      if (response.cast == 401) {
        emit(TvCastFailureAction('No Internet Connection'));
      } else {
        emit(TvCastSuccessAction(cast: response.cast));
      }
    } catch (e) {
      emit(TvCastFailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class TvCastState {}

class TvCastLoadingAction extends TvCastState {}

class TvCastFailureAction extends TvCastState {
  String? errorMessage;
  TvCastFailureAction(
    this.errorMessage,
  );
}

class TvCastSuccessAction extends TvCastState {
  List<Cast>? cast;
  TvCastSuccessAction({
    this.cast,
  });
}
