library cowpay;

import 'dart:async';
import 'dart:convert';

import 'package:cowpay/models/cach_collection_request_model.dart';
import 'package:cowpay/models/cach_collection_response_model.dart';
import 'package:cowpay/models/credit_card_request_model.dart';
import 'package:cowpay/models/fawry_request_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:cowpay/src/cash_collection_usercase.dart';
import 'package:cowpay/src/credit_card_usercase.dart';
import 'package:cowpay/src/fawry_usecase.dart';
import 'package:crypto/crypto.dart';

import 'helpers/enum_models.dart';

export 'package:cowpay/api_calls/exceptions.dart';
export 'package:cowpay/helpers/enum_models.dart';
export 'package:cowpay/ui/widgets/credit_card_widget.dart';

class Cowpay {
  static final Cowpay _instance = Cowpay._internal();

  factory Cowpay() {
    return _instance;
  }

  String? _merchantCode;
  String? _merchantHash;
  static CowpayEnvironment? activeEnvironment;
  static String? token;

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

  Future<FawryResponseModel> createFawryReceipt({
    required String merchantReferenceId,
    required String customerMerchantProfileId,
    String? customerName,
    String? customerEmail,
    String? customerMobile,
    required String amount,
    required String description,
  }) async {
    FawryUseCase _fawryUseCase = FawryUseCase();
    String signature = generateSignature([
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
      return await _fawryUseCase.createFawryReceipt(fawryRequestModel);
    } catch (error) {
      throw (error);
    }
  }

  Future<CreditCardResponseModel> creditCardCharge({
    required String merchantReferenceId,
    required String customerMerchantProfileId,
     String? customerName,
     String? customerEmail,
     String? customerMobile,
    required String cvv,
    required String cardNumber,
    required String expiryYear,
    required String expiryMonth,
    required String amount,
    required String description,
  }) async {
    CreditCardUseCase _creditCardUseCase = CreditCardUseCase();

    String signature = generateSignature([
      this._merchantCode,
      merchantReferenceId,
      customerMerchantProfileId,
      amount,
      this._merchantHash
    ]);
    CreditCardRequestModel creditCardRequestModel = CreditCardRequestModel(
        cardNumber: cardNumber,
        cvv: cvv,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        merchantReferenceId: merchantReferenceId,
        amount: amount,
        customerEmail: customerEmail,
        description: description,
        customerMerchantProfileId: customerMerchantProfileId,
        customerMobile: customerMobile,
        customerName: customerName,
        signature: signature);
    try {
      return await _creditCardUseCase
          .createCreditCardCharge(creditCardRequestModel);
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> cashCollectionCharge({
    required String merchantReferenceId,
    required String customerMerchantProfileId,
    required String customerName,
    required String customerEmail,
    required String customerMobile,
    required String address,
    required String apartment,
    required String cityCode,
    required String district,
    required floor,
    required String amount,
    required String description,
  }) async {
    CashCollectionUseCase _cashCollectionUseCase = CashCollectionUseCase();

    String signature = generateSignature([
      this._merchantCode,
      merchantReferenceId,
      customerMerchantProfileId,
      amount,
      this._merchantHash
    ]);
    CashCollectionRequestModel cashCollectionRequestModel =
        CashCollectionRequestModel(
            address: address,
            apartment: apartment,
            cityCode: cityCode,
            district: district,
            floor: floor,
            merchantReferenceId: merchantReferenceId,
            amount: amount,
            customerEmail: customerEmail,
            description: description,
            customerMerchantProfileId: customerMerchantProfileId,
            customerMobile: customerMobile,
            customerName: customerName,
            signature: signature);
    try {
      return await _cashCollectionUseCase
          .cashCollectionCharge(cashCollectionRequestModel);
    } catch (error) {
      throw error;
    }
  }

  static Cowpay get instance => _instance;

  String generateSignature(List params) {
    String concatenated = params.join("");
    String res = sha256.convert(utf8.encode(concatenated)).toString();
    return res;
  }
}
