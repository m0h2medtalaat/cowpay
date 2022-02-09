import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/features/data/models/cash_collection_request_model.dart';
import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/data/models/credit_card_request_model.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/domain/entities/credit_card_entity.dart';
import 'package:cowpay/features/domain/entities/fawry_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CowpayRepository {
  Future<Either<Failure, FawryEntity>> fawryCharge(
      {required FawryRequestModel fawryRequestModel});
  Future<Either<Failure, CreditCardEntity>> creditCardCharge(
      {required CreditCardRequestModel creditCardRequestModel});
  Future<Either<Failure, CashCollectionResponseModel>> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel});
}
