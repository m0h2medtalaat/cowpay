import 'package:cowpay/core/error/failure.dart';
import 'package:cowpay/core/usecase/usecase.dart';
import 'package:cowpay/features/domain/entities/user_entity.dart';
import 'package:cowpay/features/domain/repositories/cowpay_repository.dart';
import 'package:dartz/dartz.dart';

class FawryUseCase implements UseCase<FawryEntity, dynamic> {
  final CowpayRepository repository;

  FawryUseCase({required this.repository});

  @override
  Future<Either<Failure, FawryEntity>> call(params) async {
    return await repository.fawryCharge(fawryRequestModel: params);
  }
}
