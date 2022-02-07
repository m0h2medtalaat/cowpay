import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/data/models/fawry_response_model.dart';
import 'package:cowpay/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/usecase/usecase.dart';

class FawryUseCase implements UseCase<FawryResponseModel, dynamic> {
  final Repository repository;

  FawryUseCase({required this.repository});

  @override
  Future<Either<Failure, FawryResponseModel>> call(params) {
    return repository.fawryCharge(fawryRequestModel: params);
  }
}