class CreditCardResponseModel {
  bool? success;
  int? statusCode;
  String? statusDescription;
  String? type;
  bool? threeDSecured;
  String? paymentGatewayReferenceId;
  String? merchantReferenceId;
  int? cowpayReferenceId;

  CreditCardResponseModel(
      {this.success,
      this.statusCode,
      this.statusDescription,
      this.type,
      this.threeDSecured,
      this.paymentGatewayReferenceId,
      this.merchantReferenceId,
      this.cowpayReferenceId});

  CreditCardResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    statusDescription = json['status_description'];
    type = json['type'];
    threeDSecured = json['three_d_secured'] ?? false;
    paymentGatewayReferenceId = json['payment_gateway_reference_id'];
    merchantReferenceId = json['merchant_reference_id'];
    cowpayReferenceId = json['cowpay_reference_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['status_description'] = this.statusDescription;
    data['type'] = this.type;
    data['three_d_secured'] = this.threeDSecured;
    data['payment_gateway_reference_id'] = this.paymentGatewayReferenceId;
    data['merchant_reference_id'] = this.merchantReferenceId;
    data['cowpay_reference_id'] = this.cowpayReferenceId;
    return data;
  }
}
