// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/Api/api_services.dart';

import '../models/tv_response.dart';

class TvCubit extends Cubit<TvState> {
  TvCubit() : super(TvLoadingAction());

  void getTvOnAir(int page) async {
    var response = await ApiServices.getTvOnAir(page);
    if (response.tvResults == 401) {
      emit(TvFailureAction('No Internet Connection'));
    } else {
      emit(TvSuccessAction(
          tvResults: response.tvResults,
          pageNumber: response.page,
          totalPages: response.totalPages));
    }
  }
}

abstract class TvState {}

class TvLoadingAction extends TvState {}

class TvFailureAction extends TvState {
  String? errorMessage;
  TvFailureAction(
    this.errorMessage,
  );
}

class TvSuccessAction extends TvState {
  List<TvResults>? tvResults;
  int? pageNumber;
  int? totalPages;
  TvSuccessAction({this.tvResults, this.pageNumber, this.totalPages});
}
