import 'package:api_manager/api_manager.dart';
import 'package:cowpay/features/data/repositories/cowpay_repository_Impl.dart';
import 'package:cowpay/features/domain/usecases/cash_collection_usecase.dart';
import 'package:cowpay/features/domain/usecases/creditcard_usecase.dart';
import 'package:cowpay/features/domain/usecases/fawry_usecase.dart';
import 'package:cowpay/features/presentation/bloc/cowpay_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/data/datasources/remote_data_source.dart';
import 'features/domain/repositories/cowpay_repository.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //Bloc
  sl.registerFactory(
    () => CowpayBloc(
      fawryUseCase: sl(),
      creditCardUseCase: sl(),
      cashCollectionUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FawryUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CashCollectionUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CreditCardUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CowpayRepository>(
    () => CowpayRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl()),
  );

  //! Core

  sl.registerLazySingleton(
    () => APIsManager(),
  );

  //! External
}
