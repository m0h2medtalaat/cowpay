class FawryResponseModel {
  bool? success;
  int? statusCode;
  String? statusDescription;
  String? type;
  String? paymentGatewayReferenceId;
  String? merchantReferenceId;
  int? cowpayReferenceId;

  FawryResponseModel(
      {this.success,
      this.statusCode,
      this.statusDescription,
      this.type,
      this.paymentGatewayReferenceId,
      this.merchantReferenceId,
      this.cowpayReferenceId});

  FawryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    statusDescription = json['status_description'];
    type = json['type'];
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
    data['payment_gateway_reference_id'] = this.paymentGatewayReferenceId;
    data['merchant_reference_id'] = this.merchantReferenceId;
    data['cowpay_reference_id'] = this.cowpayReferenceId;
    return data;
  }
}
