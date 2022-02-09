import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/network/failure_handler.dart';
import 'package:cowpay/features/data/datasources/remote_data_source.dart';
import 'package:cowpay/features/data/models/cash_collection_request_model.dart';
import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/data/models/credit_card_request_model.dart';
import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/domain/entities/user_entity.dart';
import 'package:cowpay/features/domain/repositories/cowpay_repository.dart';
import 'package:dartz/dartz.dart';

class CowpayRepositoryImpl implements CowpayRepository {
  RemoteDataSource remoteDataSource;

  CowpayRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FawryEntity>> fawryCharge(
      {required FawryRequestModel fawryRequestModel}) async {
    try {
      final fawryResponseModel = await remoteDataSource.fawryCharge(
          fawryRequestModel: fawryRequestModel);
      return Right(fawryResponseModel);
      // return Left(ServerFailure(message: 'un expected error'));
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, CashCollectionResponseModel>> cashCollectionCharge(
      {required CashCollectionRequestModel cashCollectionRequestModel}) async {
    try {
      final cashCollectionResponseModel =
          await remoteDataSource.cashCollectionCharge(
              cashCollectionRequestModel: cashCollectionRequestModel);
      if (cashCollectionResponseModel != null) {
        return Right(cashCollectionResponseModel);
      }
      return Left(ParsingFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreditCardResponseModel>> creditCardCharge(
      {required CreditCardRequestModel creditCardRequestModel}) async {
    try {
      final creditCardResponseModel = await remoteDataSource.creditCardCharge(
          creditCardRequestModel: creditCardRequestModel);
      return Right(creditCardResponseModel);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }
}
