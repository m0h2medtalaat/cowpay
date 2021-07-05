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

  Future<FawryResponseModel> createFawryReceipt(
      {required String merchantReferenceId,
      required String customerMerchantProfileId,
      String? customerName,
      String? customerEmail,
      String? customerMobile,
      required String amount,
      required String description}) async {

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
      customerEmail: customerMobile,
      description: description,
      customerMerchantProfileId: customerMerchantProfileId,
      customerMobile: customerMobile,
      customerName: customerName,
      signature: signature
    );
    try{
      return await this._useCase.createFawrReceipt(fawryRequestModel);
    } catch (error){
      throw(error);
    }
  }

  static Cowpay get instance => _instance;
}
