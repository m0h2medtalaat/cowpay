import 'dart:convert';

import 'package:cowpay/core/constants/network/urls_data.dart';
import 'package:cowpay/core/network/network_util.dart';
import 'package:cowpay/features/data/models/cash_collection_request_model.dart';
import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/data/models/credit_card_request_model.dart';
import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/data/models/fawry_response_model.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteDataSource {
  Future<FawryResponseModel> fawryCharge(
      {required FawryRequestModel fawryRequestModel});
  Future<CreditCardResponseModel> creditCardCharge(
      {required CreditCardRequestModel creditCardRequestModel});
  Future<CashCollectionResponseModel> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkUtil networkUtil;

  RemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<FawryResponseModel> fawryCharge(
      {required FawryRequestModel fawryRequestModel}) {
    return _fawryChargeCall(fawryRequestModel);
  }

  @override
  Future<CashCollectionResponseModel> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel}) {
    return _cashCollectionChargeCall(cashCollectionRequestModel);
  }

  @override
  Future<CreditCardResponseModel> creditCardCharge(
      {required CreditCardRequestModel creditCardRequestModel}) {
    return _creditChargeCall(creditCardRequestModel);
  }

  //region Fawry
  Future<FawryResponseModel> _fawryChargeCall(
      FawryRequestModel fawryRequestModel) async {
    try {
      // print(fawryRequestModel.toJson());

      var res = await networkUtil.postWithRaw(UrlsData.fawryUrl,
          body: fawryRequestModel.toJson());
      FawryResponseModel fawryResponseModel =
          FawryResponseModel.fromJson(json.decode(json.encode(res)));
      debugPrint('Success ${fawryResponseModel.statusCode.toString()}');

      return fawryResponseModel;
    } on Exception catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

//endregion

  //region Credit Card
  Future<CreditCardResponseModel> _creditChargeCall(
      CreditCardRequestModel creditCardRequestModel) async {
    try {
      var res = await networkUtil.postWithRaw(UrlsData.creditCardUrl,
          body: creditCardRequestModel.toJson());
      CreditCardResponseModel model =
          CreditCardResponseModel.fromJson(json.decode(json.encode(res)));
      debugPrint('Success ${model.statusCode.toString()}');

      return model;
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

//endregion

  //region Cash Collection
  Future<CashCollectionResponseModel> _cashCollectionChargeCall(
      CashCollectionRequestModel cashCollectionRequestModel) async {
    try {
      //TODO remove comment
      /*   var res = await _netUtil.post(UrlsData.creditCardUrl,
          body: cashCollectionRequestModel.toJson());
      CashCollectionResponseModel model =
          CashCollectionResponseModel.fromJson(json.decode(json.encode(res)));
      debugPrint('Success ${res.statusCode.toString()}');

      return model;*/
      throw UnimplementedError();
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }
}
