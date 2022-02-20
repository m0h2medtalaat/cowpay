import 'package:api_manager/api_manager.dart';
import 'package:api_manager/src/failure/failures.dart';
import 'package:cowpay/cowpay/data/datasources/remote_data_source.dart';
import 'package:cowpay/cowpay/data/models/fawry_request_model.dart';
import 'package:cowpay/cowpay/data/models/fawry_response_model.dart';
import 'package:cowpay/cowpay/data/requests/fawry_charge_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApisManager extends Mock implements APIsManager {}

class FakeFawryChargeRequest extends Fake implements FawryChargeRequest {}

void main() {
  late RemoteDataSourceImpl dataSource;
  MockApisManager mockApisManager = MockApisManager();

  setUp(() {
    registerFallbackValue(FakeFawryChargeRequest());
    registerFallbackValue((map) => FawryResponseModel.fromJson(map));
    dataSource = RemoteDataSourceImpl(mockApisManager);
  });

  Future setUpMockApiManagerSendSuccess200(responseModel) async {
    when(() => mockApisManager.send(
          request: any(named: 'request'),
          responseFromMap: any(named: 'responseFromMap'),
        )).thenAnswer((_) async => responseModel);
  }

  void setUpMockHttpClientFailure404() {
    when(
      () => mockApisManager.send(
          request: any as Request,
          responseFromMap: (map) => any as Function(Map<String, dynamic> map)),
    ).thenAnswer((_) async => Left(Failures.serviceNotAvailableFailure()));
  }

  group('fawryCharge', () {
    //TODO:add call vars here

    final FawryChanrgeRequestModel fawryRequestModel = FawryChanrgeRequestModel(
        merchantReferenceId: "merchantReferenceId",
        customerMerchantProfileId: "customerMerchantProfileId",
        customerName: "customerName",
        customerEmail: "customerEmail",
        customerMobile: "customerMobile",
        amount: "amount",
        signature: "signature",
        description: "description");
    final FawryChargeRequest fawryChargeRequest =
        FawryChargeRequest(fawryRequestModel);

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockApiManagerSendSuccess200(Future.value(Right(FawryResponseModel(
                success: true,
                cowpayReferenceId: 11,
                merchantReferenceId: "sds",
                statusCode: 200,
                statusDescription: "ok",
                type: "fawry",
                paymentGatewayReferenceId: "11")))
            as Future<Either<Failure, FawryResponseModel>>);

        // act
        await dataSource.fawryCharge(fawryRequestModel: fawryRequestModel);
        // assert
        verify(() => mockApisManager.send(
              request: fawryChargeRequest,
              responseFromMap: (map) => FawryResponseModel.fromJson(map),
            ));
      },
    );
    //
    // test(
    //   'should return NumberTrivia when the response code is 200 (success)',
    //   () async {
    //     // arrange
    //     setUpMockApiManagerSendSuccess200();
    //     // act
    //     final result = await dataSource.getConcreteNumberTrivia(tNumber);
    //     // assert
    //     expect(result, equals(tNumberTriviaModel));
    //   },
    // );
    //
    // test(
    //   'should throw a ServerException when the response code is 404 or other',
    //   () async {
    //     // arrange
    //     setUpMockHttpClientFailure404();
    //     // act
    //     final call = dataSource.getConcreteNumberTrivia;
    //     // assert
    //     expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    //   },
    // );
  });

  // group('getRandomNumberTrivia', () {
  //   final tNumberTriviaModel =
  //       NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
  //
  //   test(
  //     '''should perform a GET request on a URL with number
  //      being the endpoint and with application/json header''',
  //     () async {
  //       // arrange
  //       setUpMockApiManagerSendSuccess200();
  //       // act
  //       dataSource.getRandomNumberTrivia();
  //       // assert
  //       verify(mockApisManager.get(
  //         'http://numbersapi.com/random',
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //       ));
  //     },
  //   );
  //
  //   test(
  //     'should return NumberTrivia when the response code is 200 (success)',
  //     () async {
  //       // arrange
  //       setUpMockApiManagerSendSuccess200();
  //       // act
  //       final result = await dataSource.getRandomNumberTrivia();
  //       // assert
  //       expect(result, equals(tNumberTriviaModel));
  //     },
  //   );
  //
  //   test(
  //     'should throw a ServerException when the response code is 404 or other',
  //     () async {
  //       // arrange
  //       setUpMockHttpClientFailure404();
  //       // act
  //       final call = dataSource.getRandomNumberTrivia;
  //       // assert
  //       expect(() => call(), throwsA(TypeMatcher<ServerException>()));
  //     },
  //   );
  // });
}
