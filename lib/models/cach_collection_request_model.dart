class CashCollectionRequestModel {
  String? merchantReferenceId;
  String? customerMerchantProfileId;
  String? amount;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  String? address;
  String? district;
  String? apartment;
  String? floor;
  String? signature;
  String? description;
  String? cityCode;

  CashCollectionRequestModel(
      {this.merchantReferenceId,
      this.customerMerchantProfileId,
      this.amount,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      this.address,
      this.district,
      this.apartment,
      this.floor,
      this.signature,
      this.description,
      this.cityCode});

  CashCollectionRequestModel.fromJson(Map<String, dynamic> json) {
    merchantReferenceId = json['merchant_reference_id'];
    customerMerchantProfileId = json['customer_merchant_profile_id'];
    amount = json['amount'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerMobile = json['customer_mobile'];
    address = json['address'];
    district = json['district'];
    apartment = json['apartment'];
    floor = json['floor'];
    signature = json['signature'];
    description = json['description'];
    cityCode = json['city_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_reference_id'] = this.merchantReferenceId;
    data['customer_merchant_profile_id'] = this.customerMerchantProfileId;
    data['amount'] = this.amount;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_mobile'] = this.customerMobile;
    data['address'] = this.address;
    data['district'] = this.district;
    data['apartment'] = this.apartment;
    data['floor'] = this.floor;
    data['signature'] = this.signature;
    data['description'] = this.description;
    data['city_code'] = this.cityCode;
    return data;
  }
}
