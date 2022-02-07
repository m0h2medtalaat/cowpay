import 'package:cowpay/features/data/models/cash_collection_response_model.dart';
import 'package:cowpay/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/usecase/usecase.dart';

class CashCollectionUseCase implements UseCase<CashCollectionResponseModel, dynamic> {
  final Repository repository;

  CashCollectionUseCase({required this.repository});

  @override
  Future<Either<Failure, CashCollectionResponseModel>> call(params) {
    return repository.cashCollectionCharge(cashCollectionRequestModel: params);
  }
}