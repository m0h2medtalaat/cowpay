library cowpay;

import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:cowpay/src/fawry_usecase.dart';

import 'helpers/enum_models.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class Cowpay {


  static final Cowpay _instance = Cowpay._internal();

  factory Cowpay() {
    return _instance;
  }

  String? _authToken;
  String? _merchantCode;
  String? _merchantHash;
  static CowpayEnvironment? activeEnvironment;
  static String? token;
  FawryUseCase  useCase = FawryUseCase();

  Cowpay._internal();

  void init(
      {required CowpayEnvironment cowpayEnvironment, required String token, required String merchantCode,
        required String merchantHash,
        required String authToken,}) {
    activeEnvironment = cowpayEnvironment;
    Cowpay.token = token;
    this._authToken = authToken;
    this._merchantCode = merchantCode;
    this._merchantHash = merchantHash;
  }


  Future <FawryResponseModel> createFawryReceipt(FawryRequestModel fawryRequestModel)async{
    return await this.useCase.createFawrReceipt(fawryRequestModel);
  }


  static Cowpay get instance => _instance;

}
