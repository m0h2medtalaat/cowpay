import 'package:cowpay/core/network/network_util.dart';
import 'package:cowpay/features/data/datasources/remote_data_source.dart';
import 'package:cowpay/features/data/models/fawry_request_model.dart';
import 'package:cowpay/features/data/models/fawry_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NetworkUtil>(as: #MockNetworkUtil, returnNullOnMissingStub: true)
])
void main() {
  group('getConcreteNumberTrivia', () {
    MockNetworkUtil mockNetworkUtil = MockNetworkUtil();

    RemoteDataSourceImpl remoteDataSourceImpl =
        RemoteDataSourceImpl(networkUtil: mockNetworkUtil);

    FawryResponseModel fawryResponseModel = FawryResponseModel(
        paymentGatewayReferenceId: "paymentGatewayReferenceId",
        merchantReferenceId: "merchantReferenceId",
        cowpayReferenceId: 111,
        success: true,
        statusCode: 200,
        statusDescription: "200",
        type: "fawry");

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        when(
          mockNetworkUtil.postWithRaw("https://cowpay.me/api/v1/charge/fawry",
              body: FawryRequestModel(
                      merchantReferenceId: "merchantReferenceId",
                      customerMerchantProfileId: "customerMerchantProfileId",
                      amount: "amount",
                      signature: "signature",
                      description: "description")
                  .toJson()),
        ).thenAnswer((_) async => fawryResponseModel);
        // act
        remoteDataSourceImpl.fawryCharge(
            fawryRequestModel: FawryRequestModel(
                merchantReferenceId: "merchantReferenceId",
                customerMerchantProfileId: "customerMerchantProfileId",
                amount: "amount",
                signature: "signature",
                description: "description"));
        // assert
        verify(mockNetworkUtil.postWithRaw(
          'https://cowpay.me/api/v1/charge/fawry',
          body: FawryRequestModel(
                  merchantReferenceId: "merchantReferenceId",
                  customerMerchantProfileId: "customerMerchantProfileId",
                  amount: "amount",
                  signature: "signature",
                  description: "description")
              .toJson(),
        ));
      },
    );
  });
}
