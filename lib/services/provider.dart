import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  String userName = "";

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }
}