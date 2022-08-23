import 'package:flutter/cupertino.dart';

import '../model/users.dart';

class ChatProvider extends ChangeNotifier {
  bool _showSend=false;

  bool get showSend => _showSend;

  void setShowSend(bool value) {
    _showSend = value;
    notifyListeners();
  }
}
