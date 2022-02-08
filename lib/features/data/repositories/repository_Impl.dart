import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/network/failure_handler.dart';
import 'package:cowpay/features/data/datasources/remote_data_source.dart';
import 'package:cowpay/features/data/models/cash_collection_request_model.dart';
import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/data/models/credit_card_request_model.dart';
import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/data/models/fawry_response_model.dart';
import 'package:cowpay/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource remoteDataSource;
  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FawryResponseModel>> fawryCharge(
      {required FawryRequestModel fawryRequestModel}) async {
    try {
      final fawryResponseModel = await remoteDataSource.fawryCharge(
          fawryRequestModel: fawryRequestModel);
      if (fawryResponseModel != null) {
        return Right(fawryResponseModel);
      }
      return Left(ParsingFailure());
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
      if (creditCardResponseModel != null) {
        return Right(creditCardResponseModel);
      }
      return Left(ParsingFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
