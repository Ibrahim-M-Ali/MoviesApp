// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../Api/api_profile_services.dart';

// class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
//   ProfileDetailsCubit() : super(LoadingAction());

//   void loadNowMovies() async {
//     try {
//       var response = await ApiProfile.getAccoutDetails();
//       if (response == null) {
//         emit(FailureAction('No Internet Connection'));
//       } else {
//         emit(SuccessAction(results: response));
//       }
//     } catch (e) {
//       emit(FailureAction('Error Message ${e.toString()}'));
//     }
//   }
// }

// abstract class ProfileDetailsState {}

// class LoadingAction extends ProfileDetailsState {}

// class FailureAction extends ProfileDetailsState {
//   String? errorMessage;
//   FailureAction(
//     this.errorMessage,
//   );
// }

// class SuccessAction extends ProfileDetailsState {
//   List? results;
//   SuccessAction({
//     this.results,
//   });
// }
