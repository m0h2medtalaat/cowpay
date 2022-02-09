import 'package:cowpay/features/domain/entities/credit_card_entity.dart';

class CreditCardResponseModel extends CreditCardEntity {
  bool? success;
  int? statusCode;
  String? statusDescription;
  String? type;
  bool? threeDSecured;
  String? paymentGatewayReferenceId;
  String? merchantReferenceId;
  int? cowpayReferenceId;

  CreditCardResponseModel(
      {success,
      statusCode,
      statusDescription,
      type,
      threeDSecured,
      paymentGatewayReferenceId,
      merchantReferenceId,
      cowpayReferenceId})
      : super(
          success: success,
          statusCode: statusCode,
          statusDescription: statusDescription,
          type: type,
          threeDSecured: threeDSecured,
          paymentGatewayReferenceId: paymentGatewayReferenceId,
          merchantReferenceId: merchantReferenceId,
          cowpayReferenceId: cowpayReferenceId,
        );
  factory CreditCardResponseModel.fromJson(Map<String, dynamic> json) {
    return CreditCardResponseModel(
      success: json['success'],
      statusCode: json['status_code'],
      statusDescription: json['status_description'],
      type: json['type'],
      paymentGatewayReferenceId: json['payment_gateway_reference_id'],
      cowpayReferenceId: json['cowpay_reference_id'],
      merchantReferenceId: json['merchant_reference_id'],
      threeDSecured: json['three_d_secured'] ?? false,
    );
  }
}
