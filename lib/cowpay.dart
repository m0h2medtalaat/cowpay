library cowpay;

import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/src/fawry_usecase.dart';

import 'helpers/enum_models.dart';
import 'models/fawry_response_model.dart';

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

  String? _merchantCode;
  String? _merchantHash;
  static CowpayEnvironment? activeEnvironment;
  static String? token;

  FawryUseCase _useCase = FawryUseCase();

  Cowpay._internal();

  void init({
    required CowpayEnvironment cowpayEnvironment,
    required String token,
    required String merchantCode,
    required String merchantHash,
  }) {
    activeEnvironment = cowpayEnvironment;
    Cowpay.token = token;
    this._merchantCode = merchantCode;
    this._merchantHash = merchantHash;
  }

  Future<void> createFawryReceipt(
      {required String merchantReferenceId,
      required String customerMerchantProfileId,
      String? customerName,
      String? customerEmail,
      String? customerMobile,
      required String amount,
      required String description,
      required Function(FawryResponseModel fawryResponseModel) onSuccess,
      required Function(String messagge) onError}) async {
    String signature = this._useCase.generateSignature([
      this._merchantCode,
      merchantReferenceId,
      customerMerchantProfileId,
      amount,
      this._merchantHash
    ]);
    FawryRequestModel fawryRequestModel = FawryRequestModel(
        merchantReferenceId: merchantReferenceId,
        amount: amount,
        customerEmail: customerEmail,
        description: description,
        customerMerchantProfileId: customerMerchantProfileId,
        customerMobile: customerMobile,
        customerName: customerName,
        signature: signature);
    try {
      var model = await this._useCase.createFawryReceipt(fawryRequestModel);
      onSuccess(model);
    } catch (error) {
      onError(error.toString());
    }
  }

  static Cowpay get instance => _instance;
}
