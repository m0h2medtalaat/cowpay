class FawryRequestModel {
  String? merchantReferenceId;
  String? customerMerchantProfileId;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  String? amount;
  String? signature;
  String? description;

  FawryRequestModel(
      {required this.merchantReferenceId,
      required this.customerMerchantProfileId,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      required this.amount,
      required this.signature,
      required this.description});

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
