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
      {this.merchantReferenceId,
      this.customerMerchantProfileId,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      this.amount,
      this.signature,
      this.description});

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
