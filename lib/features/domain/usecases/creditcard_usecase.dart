import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/usecase/usecase.dart';

class CreditCardUseCase implements UseCase<CreditCardResponseModel, dynamic> {
  final Repository repository;

  CreditCardUseCase({required this.repository});

  @override
  Future<Either<Failure, CreditCardResponseModel>> call(params) {
    return repository.creditCardCharge(creditCardRequestModel: params);
  }
}