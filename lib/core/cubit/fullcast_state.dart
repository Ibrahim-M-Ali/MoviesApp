// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/Api/api_services.dart';

import '../models/actors_response.dart';

class FullCastCubit extends Cubit<FullCastState> {
  FullCastCubit() : super(CastLoadingAction());

  void loadFullCast(movieID) async {
    try {
      var response = await ApiServices.gotFullCast(movieID);
      if (response.cast == 401) {
        emit(CastFailureAction('No Internet Connection'));
      } else {
        emit(CastSuccessAction(cast: response.cast));
      }
    } catch (e) {
      emit(CastFailureAction('Error Message ${e.toString()}'));
    }
  }
}

abstract class FullCastState {}

class CastLoadingAction extends FullCastState {}

class CastFailureAction extends FullCastState {
  String? errorMessage;
  CastFailureAction(
    this.errorMessage,
  );
}

class CastSuccessAction extends FullCastState {
  List<Cast>? cast;
  CastSuccessAction({
    this.cast,
  });
}
