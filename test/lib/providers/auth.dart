import 'package:flutter/material.dart';
import 'package:test/api/models.dart';
import 'package:test/api/http_services.dart';

class AuthProvider extends ChangeNotifier {
  HttpServices httpService = HttpServices();
  bool allow = false;

  /// username: cabic60931@onlcool.com
  /// password: E4ts&4H-
  void login(String email, String password) async {
    try {
      await httpService.login(email: email, password: password);
      allow = true;
      notifyListeners();
    } on Login catch (error, _) {
      // show dialog message
      print(error.errorMsg);
    }
  }
}
