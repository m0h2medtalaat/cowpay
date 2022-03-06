import 'package:api_manager/api_manager.dart';
import 'package:api_manager/failures.dart';
import 'package:api_manager/src/failure/failures.dart';
import 'package:cowpay/cowpay/data/datasources/remote_data_source.dart';
import 'package:cowpay/cowpay/data/models/credit_card_request_model.dart';
import 'package:cowpay/cowpay/data/models/credit_card_response_model.dart';
import 'package:cowpay/cowpay/data/models/fawry_request_model.dart';
import 'package:cowpay/cowpay/data/models/fawry_response_model.dart';
import 'package:cowpay/cowpay/data/requests/credit_card_charge_request.dart';
import 'package:cowpay/cowpay/data/requests/fawry_charge_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApisManager extends Mock implements APIsManager {}

void main() {
  late RemoteDataSourceImpl dataSource;
  MockApisManager mockApisManager = MockApisManager();
  final FawryChargeRequestModel fawryRequestModel = FawryChargeRequestModel(
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
  Either<Failure, FawryResponseModel> fawryFailure404 =
      Left(ServiceNotAvailableFailure());
  Either<Failure, CreditCardResponseModel> cardFailure404 =
      Left(ServiceNotAvailableFailure());

  final CreditCardChargeRequestModel creditCardRequestModel =
      CreditCardChargeRequestModel(
          merchantReferenceId: "merchantReferenceId",
          customerMerchantProfileId: "customerMerchantProfileId",
          customerName: "customerName",
          customerEmail: "customerEmail",
          customerMobile: "customerMobile",
          amount: "amount",
          signature: "signature",
          description: "description",
          cardNumber: '123',
          expiryYear: '123',
          cvv: '123',
          expiryMonth: '12');

  final CreditCardChargeRequest creditCardRequest =
      CreditCardChargeRequest(creditCardRequestModel);

  setUp(() {
    registerFallbackValue(fawryChargeRequest);
    registerFallbackValue(creditCardRequest);
    registerFallbackValue((map) => FawryResponseModel.fromJson(map));
    registerFallbackValue((map) => CreditCardResponseModel.fromJson(map));
    dataSource = RemoteDataSourceImpl(mockApisManager);
  });

  group('Fawry Charge', () {
    Future setUpMockApiManagerSendSuccess200(
        Future<Either<Failure, FawryResponseModel>> responseModel) async {
      when(() => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap'),
          )).thenAnswer((_) async => responseModel);
    }

    void setUpMockApiManagerFailure404() {
      when(
        () => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap')),
      ).thenAnswer((_) async => fawryFailure404);
    }

    Either<Failure, FawryResponseModel> responseModel = Right(
      FawryResponseModel(
          success: true,
          cowpayReferenceId: 11,
          merchantReferenceId: "sds",
          statusCode: 200,
          statusDescription: "ok",
          type: "fawry",
          paymentGatewayReferenceId: "11"),
    );

    test(
      '''should perform a Send request on a URL with fawryRequestModel
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockApiManagerSendSuccess200(Future.value(
          responseModel,
        ));

        // act
        await dataSource.fawryCharge(fawryRequestModel: fawryRequestModel);
        // assert
        verify(() => mockApisManager.send(
              request: any(named: 'request'),
              responseFromMap: any(named: 'responseFromMap'),
            ));
      },
    );

    test(
      'should return FawryResponseModel when the response code is 200 (success)',
      () async {
        // arrange

        setUpMockApiManagerSendSuccess200(
          Future.value(responseModel),
        );
        // act
        final result = await dataSource.fawryCharge(
          fawryRequestModel: fawryRequestModel,
        ) as Right<dynamic, FawryResponseModel>;
        // assert
        verify(
          () => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap'),
          ),
        );
        // assert
        expect(
          result,
          equals(
            responseModel,
          ),
        );
      },
    );

    test(
      'should throw a Failure404 when the response code is 404 or other',
      () async {
        // arrange
        setUpMockApiManagerFailure404();
        // act
        Either<Failure, FawryResponseModel> result =
            await dataSource.fawryCharge(fawryRequestModel: fawryRequestModel);
        // assert
        expect(result, equals(fawryFailure404));
      },
    );
  });
  group('Card Charge', () {
    Future setUpMockApiManagerSendSuccess200(
        Future<Either<Failure, CreditCardResponseModel>> responseModel) async {
      when(() => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap'),
          )).thenAnswer((_) async => responseModel);
    }

    void setUpMockApiManagerFailure404() {
      when(
        () => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap')),
      ).thenAnswer((_) async => cardFailure404);
    }

    Either<Failure, CreditCardResponseModel> responseModel = Right(
      CreditCardResponseModel(
          success: true,
          cowpayReferenceId: 11,
          merchantReferenceId: "sds",
          statusCode: 200,
          statusDescription: "ok",
          type: "fawry",
          paymentGatewayReferenceId: "11"),
    );

    test(
      '''should perform a Send request on a URL with creditCardRequestModel
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockApiManagerSendSuccess200(Future.value(
          responseModel,
        ));

        // act
        await dataSource.creditCardCharge(
            creditCardRequestModel: creditCardRequestModel);
        // assert
        verify(() => mockApisManager.send(
              request: any(named: 'request'),
              responseFromMap: any(named: 'responseFromMap'),
            ));
      },
    );

    test(
      'should return CreditCardResponseModel when the response code is 200 (success)',
      () async {
        // arrange

        setUpMockApiManagerSendSuccess200(
          Future.value(responseModel),
        );
        // act
        final result = await dataSource.creditCardCharge(
          creditCardRequestModel: creditCardRequestModel,
        ) as Right<dynamic, CreditCardResponseModel>;
        // assert
        verify(
          () => mockApisManager.send(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap'),
          ),
        );
        // assert
        expect(
          result,
          equals(
            responseModel,
          ),
        );
      },
    );

    test(
      'should throw a SetUpMockApiManagerFailure404 when the response code is 404 or other',
      () async {
        // arrange
        setUpMockApiManagerFailure404();
        // act
        Either<Failure, CreditCardResponseModel> result = await dataSource
            .creditCardCharge(creditCardRequestModel: creditCardRequestModel);
        // assert
        expect(result, equals(cardFailure404));
      },
    );
  });
}
