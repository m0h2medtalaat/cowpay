library cowpay;

import 'helpers/enum_models.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class Cowpay {
  static CowpayEnvironment? activeEnvironment;
  static String? token;

  void init(
      {required CowpayEnvironment cowpayEnvironment, required String token}) {
    activeEnvironment = cowpayEnvironment;
    Cowpay.token = token;
  }
}
