import 'package:flutter/foundation.dart';

class LoginStatus extends ChangeNotifier {
  bool status = false; //true  (using provider)

  setStatus(bool val) {
    this.status = val;
    notifyListeners();
  }
}
