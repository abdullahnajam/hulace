import 'package:flutter/cupertino.dart';

import '../model/users.dart';

class UserDataProvider extends ChangeNotifier {
  int _count=0;
  UserModel? userData;

  void setUserData(UserModel user) {
    this.userData = user;
    notifyListeners();
  }

  void increase() {
    _count++;
    notifyListeners();
  }

  int get count => _count;

  void decrease() {
    _count--;
    notifyListeners();
  }


}
