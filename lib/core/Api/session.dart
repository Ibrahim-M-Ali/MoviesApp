import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String accessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOTRhYjFlMDEyYTk5MzJkZmIwNDBjZDU5NzUzZDgxMCIsInN1YiI6IjY0NzdiY2U1Y2Y0YjhiMDBjM2QwN2U0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gFfFeRkncp5ZNToihz_0UYjxp4udtgSyfOCIG_-9vGk';
String requestToken = "";
String sessionID = "";

class SessionOpreation {
  Future<void> performOperations() async {
    await getToken();
    await Future.delayed(Duration(seconds: 15));
    await getSession();
  }

  Future<void> getToken() async {
    http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/authentication/token/new'),
      headers: {
        "accept": 'application/json',
        "Authorization": 'Bearer $accessToken'
      },
    );
    var data = jsonDecode(response.body);

    requestToken = await data['request_token'];

    String url = 'https://www.themoviedb.org/authenticate/$requestToken';
    // print(key);
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      print('Could not launch $e');
    }
  }

  Future<void> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var responseSession = await http.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/session/new'),
        headers: {
          "accept": 'application/json',
          'content-type': 'application/json',
          "Authorization": 'Bearer $accessToken'
        },
        body: jsonEncode({"request_token": requestToken}),
      );

      var dataSession = await jsonDecode(responseSession.body);
      sessionID = dataSession['session_id'];
      prefs.setString("sessionID", sessionID);
      print(prefs.getString("sessionID"));
    } catch (e) {
      print(e);
    }
  }
}
