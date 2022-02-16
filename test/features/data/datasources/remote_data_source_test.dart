import 'package:api_manager/api_manager.dart';
import 'package:cowpay/cowpay/data/datasources/remote_data_source.dart';
import 'package:cowpay/cowpay/data/models/fawry_request_model.dart';
import 'package:cowpay/cowpay/data/models/fawry_response_model.dart';
import 'package:cowpay/cowpay/data/requests/fawry_charge_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_data_source_test.mocks.dart';

// class MockApisManager extends Mock implements APIsManager {}

// @GenerateMocks(
//   [APIsManager],
// )
@GenerateMocks([], customMocks: [
  MockSpec<APIsManager>(as: #MockAPIsManager, returnNullOnMissingStub: true),
  MockSpec<RemoteDataSource>(
      as: #MockRemoteDataSourceImpl, returnNullOnMissingStub: true)
])
void main() {
  // late RemoteDataSourceImpl dataSource;
  // MockApisManager mockApisManager = MockApisManager();

  setUp(() {
    // mockApisManager = MockApisManager();
    // dataSource = RemoteDataSourceImpl(mockApisManager);

    // var res = mockApisManager.send(
    //     request: FawryChargeRequest(FawryRequestModel(
    //         merchantReferenceId: "merchantReferenceId",
    //         customerMerchantProfileId: "customerMerchantProfileId",
    //         customerName: "customereName",
    //         customerEmail: "customerEmail",
    //         customerMobile: "customerMobile",
    //         amount: "amount",
    //         signature: "signature",
    //         description: "description")),
    //     responseFromMap: (map) => FawryResponseModel.fromJson(map));
    //
    // print(res.toString());
  });

  // void setUpMockApiManagerSendSuccess200(responseModel, Request request,
  //     Function(Map<String, dynamic> map) fromJsonFunction) {
  //   when(mockApisManager.send(
  //     request: FawryChargeRequest(FawryRequestModel(
  //         merchantReferenceId: "merchantReferenceId",
  //         customerMerchantProfileId: "customerMerchantProfileId",
  //         customerName: "customereName",
  //         customerEmail: "customerEmail",
  //         customerMobile: "customerMobile",
  //         amount: "amount",
  //         signature: "signature",
  //         description: "description")),
  //     responseFromMap: (map) => FawryResponseModel.fromJson(map),
  //   )).thenAnswer((_) async => Right(FawryResponseModel(
  //       success: true,
  //       cowpayReferenceId: 11,
  //       merchantReferenceId: "sds",
  //       statusCode: 200,
  //       statusDescription: "ok",
  //       type: "fawry",
  //       paymentGatewayReferenceId: "11")));
  // }
  // void setUpMockApiManagerSendSuccess200(responseModel, Request request,
  //     Function(Map<String, dynamic> map) fromJsonFunction) {
  // mockApisManager.send(
  //     request: FawryChargeRequest(FawryRequestModel(
  //         merchantReferenceId: "merchantReferenceId",
  //         customerMerchantProfileId: "customerMerchantProfileId",
  //         customerName: "customerName",
  //         customerEmail: "customerEmail",
  //         customerMobile: "customerMobile",
  //         amount: "amount",
  //         signature: "signature",
  //         description: "description")),
  //     responseFromMap: (map) => FawryResponseModel.fromJson(map),
  //   );
  // }

  // void setUpMockHttpClientFailure404() {
  //   when(
  //     mockApisManager.send(
  //         request: any as Request,
  //         responseFromMap: (map) => any as Function(Map<String, dynamic> map)),
  //   ).thenAnswer((_) async => Left(Failures.serviceNotAvailableFailure()));
  // }

  group('fawryCharge', () {
    //TODO:add call vars here
    // final tNumber = 1;
    // final tNumberTriviaModel =
    //     NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        // setUpMockApiManagerSendSuccess200(
        //   FawryResponseModel(
        //       success: true,
        //       cowpayReferenceId: 11,
        //       merchantReferenceId: "sds",
        //       statusCode: 200,
        //       statusDescription: "ok",
        //       type: "fawry",
        //       paymentGatewayReferenceId: "11"),
        //   FawryChargeRequest(FawryRequestModel(
        //       merchantReferenceId: "merchantReferenceId",
        //       customerMerchantProfileId: "customerMerchantProfileId",
        //       customerName: "customerName",
        //       customerEmail: "customerEmail",
        //       customerMobile: "customerMobile",
        //       amount: "amount",
        //       signature: "signature",
        //       description: "description")),
        //   (map) => FawryResponseModel.fromJson(map),
        // );
        MockAPIsManager mockApisManager = MockAPIsManager();
        RemoteDataSourceImpl dataSourceImpl =
            RemoteDataSourceImpl(mockApisManager);

        // mockApisManager.send(
        //   request: FawryChargeRequest(FawryRequestModel(
        //       merchantReferenceId: "merchantReferenceId",
        //       customerMerchantProfileId: "customerMerchantProfileId",
        //       customerName: "customerName",
        //       customerEmail: "customerEmail",
        //       customerMobile: "customerMobile",
        //       amount: "amount",
        //       signature: "signature",
        //       description: "description")),
        //   responseFromMap: (map) => FawryResponseModel.fromJson(map),
        // );

        when(mockApisManager.send(
          request: FawryChargeRequest(FawryRequestModel(
              merchantReferenceId: "merchantReferenceId",
              customerMerchantProfileId: "customerMerchantProfileId",
              customerName: "customerName",
              customerEmail: "customerEmail",
              customerMobile: "customerMobile",
              amount: "amount",
              signature: "signature",
              description: "description")),
          responseFromMap: (map) => FawryResponseModel.fromJson(map),
        )).thenAnswer((_) async => Right(FawryResponseModel(
            success: true,
            cowpayReferenceId: 11,
            merchantReferenceId: "sds",
            statusCode: 200,
            statusDescription: "ok",
            type: "fawry",
            paymentGatewayReferenceId: "11")));
        // act
        dataSourceImpl.fawryCharge(
            fawryRequestModel: FawryRequestModel(
                merchantReferenceId: "merchantReferenceId",
                customerMerchantProfileId: "customerMerchantProfileId",
                customerName: "customerName",
                customerEmail: "customerEmail",
                customerMobile: "customerMobile",
                amount: "amount",
                signature: "signature",
                description: "description"));
        // assert
        verify(mockApisManager.send(
          request: FawryChargeRequest(FawryRequestModel(
              merchantReferenceId: "merchantReferenceId",
              customerMerchantProfileId: "customerMerchantProfileId",
              customerName: "customerName",
              customerEmail: "customerEmail",
              customerMobile: "customerMobile",
              amount: "amount",
              signature: "signature",
              description: "description")),
          responseFromMap: (map) => FawryResponseModel.fromJson(map),
        )).called(1);
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
