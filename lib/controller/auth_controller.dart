import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String url = "http://10.0.2.2:3000";
  // final String url = "http://192.168.150.17:3000";
  var isLoading = false.obs;
  var isLogedin = false.obs;
  var message = "".obs;

  login(Map<String, dynamic> payload) async {
    isLoading(true);
    message("");

    final response = await http.post(Uri.parse('$url/login'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json"});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final accessToken = data['access_token'];
      final pref = await SharedPreferences.getInstance();
      await pref.setString("access_token", accessToken);
      await pref.setString("user", jsonEncode(data['user']));
      isLogedin(true);
    } else if (response.statusCode == 422) {
      final errors = data['errors'];
      final error = errors[0];
      message(error['msg']);
      isLogedin(false);
    } else {
      message(data['message']);
      isLogedin(false);
    }

    isLoading(false);
  }

  Logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    isLogedin(false);
  }
}
