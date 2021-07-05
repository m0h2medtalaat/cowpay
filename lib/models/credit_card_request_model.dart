class CreditCardRequestModel {
  String? merchantReferenceId;
  String? customerMerchantProfileId;
  String? cardNumber;
  String? cvv;
  String? expiryMonth;
  String? expiryYear;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  String? amount;
  String? signature;
  String? description;

  CreditCardRequestModel(
      {this.merchantReferenceId,
      this.customerMerchantProfileId,
      this.cardNumber,
      this.cvv,
      this.expiryMonth,
      this.expiryYear,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      this.amount,
      this.signature,
      this.description});

  CreditCardRequestModel.fromJson(Map<String, dynamic> json) {
    merchantReferenceId = json['merchant_reference_id'];
    customerMerchantProfileId = json['customer_merchant_profile_id'];
    cardNumber = json['card_number'];
    cvv = json['cvv'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
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
    data['card_number'] = this.cardNumber;
    data['cvv'] = this.cvv;
    data['expiry_month'] = this.expiryMonth;
    data['expiry_year'] = this.expiryYear;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_mobile'] = this.customerMobile;
    data['amount'] = this.amount;
    data['signature'] = this.signature;
    data['description'] = this.description;
    return data;
  }
}
