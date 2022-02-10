import 'package:api_manager/api_manager.dart';
import 'package:api_manager/src/failure/failures.dart';
import 'package:cowpay/features/data/models/cash_collection_request_model.dart';
import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/data/models/credit_card_request_model.dart';
import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/data/models/fawry_response_model.dart';
import 'package:cowpay/features/data/requests/credit_card_charge_request.dart';
import 'package:cowpay/features/data/requests/fawry_charge_request.dart';
import 'package:cowpay/features/domain/entities/credit_card_entity.dart';
import 'package:cowpay/features/domain/entities/fawry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, FawryEntity>> fawryCharge(
      {required FawryRequestModel fawryRequestModel});

  Future<Either<Failure, CreditCardEntity>> creditCardCharge(
      {required CreditCardChargeRequestModel creditCardRequestModel});

  Future<Either<Failure, CashCollectionResponseModel>> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIsManager _apIsManager;

  RemoteDataSourceImpl(this._apIsManager);

  @override
  Future<Either<Failure, FawryResponseModel>> fawryCharge(
      {required FawryRequestModel fawryRequestModel}) {
    return _fawryChargeCall(fawryRequestModel);
  }

  @override
  Future<Either<Failure, CashCollectionResponseModel>> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel}) {
    return _cashCollectionChargeCall(cashCollectionRequestModel);
  }

  @override
  Future<Either<Failure, CreditCardResponseModel>> creditCardCharge(
      {required CreditCardChargeRequestModel creditCardRequestModel}) {
    return _creditChargeCall(creditCardRequestModel);
  }

  //region Fawry
  Future<Either<Failure, FawryResponseModel>> _fawryChargeCall(
      FawryRequestModel fawryRequestModel) async {
    try {
      return await _apIsManager.send(
        request: FawryChargeRequest(fawryRequestModel),
        responseFromMap: (map) => FawryResponseModel.fromJson(map),
      );
    } on Exception catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

//endregion

  //region Credit Card
  Future<Either<Failure, CreditCardResponseModel>> _creditChargeCall(
      CreditCardChargeRequestModel creditCardRequestModel) async {
    try {
      return await _apIsManager.send(
        request: CreditCardChargeRequest(creditCardRequestModel),
        responseFromMap: (map) => CreditCardResponseModel.fromJson(map),
      );
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

//endregion

  //region Cash Collection
  Future<Either<Failure, CashCollectionResponseModel>>
      _cashCollectionChargeCall(
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
