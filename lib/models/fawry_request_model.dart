class FawryRequestModel {
  late String merchantReferenceId;
  late String customerMerchantProfileId;
  late String customerName;
  late String customerEmail;
  late String customerMobile;
  late String amount;
  late String signature;
  late String description;

  FawryRequestModel(
      {required this.merchantReferenceId,
      required this.customerMerchantProfileId,
      required this.customerName,
      required this.customerEmail,
      required this.customerMobile,
      required this.amount,
      required this.signature,
      required this.description});

  FawryRequestModel.fromJson(Map<String, dynamic> json) {
    merchantReferenceId = json['merchant_reference_id'];
    customerMerchantProfileId = json['customer_merchant_profile_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerMobile = json['customer_mobile'];
    amount = json['amount'];
    signature = json['signature'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_reference_id'] = this.merchantReferenceId;
    data['customer_merchant_profile_id'] = this.customerMerchantProfileId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_mobile'] = this.customerMobile;
    data['amount'] = this.amount;
    data['signature'] = this.signature;
    data['description'] = this.description;
    return data;
  }
}
