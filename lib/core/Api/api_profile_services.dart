import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/profile_details_response.dart';

class ApiProfile {
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOTRhYjFlMDEyYTk5MzJkZmIwNDBjZDU5NzUzZDgxMCIsInN1YiI6IjY0NzdiY2U1Y2Y0YjhiMDBjM2QwN2U0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gFfFeRkncp5ZNToihz_0UYjxp4udtgSyfOCIG_-9vGk';

  static Future<ProfileDetailsResponse> getAccoutDetails() async {
    http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/account/19757181'),
      headers: {
        "accept": 'application/json',
        "Authorization": 'Bearer $accessToken'
      },
    );

    return ProfileDetailsResponse.fromJson(jsonDecode((response.body)));
  }
}
