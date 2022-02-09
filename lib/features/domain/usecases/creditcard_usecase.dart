import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/usecase/usecase.dart';
import 'package:cowpay/features/data/models/credit_card_response_model.dart';
import 'package:cowpay/features/domain/repositories/cowpay_repository.dart';
import 'package:dartz/dartz.dart';

class CreditCardUseCase implements UseCase<CreditCardResponseModel, dynamic> {
  final CowpayRepository repository;

  CreditCardUseCase({required this.repository});

  @override
  Future<Either<Failure, CreditCardResponseModel>> call(params) {
    return repository.creditCardCharge(creditCardRequestModel: params);
  }
}
