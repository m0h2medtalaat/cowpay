class CreditCardRequestModel {
  late String merchantReferenceId;
  late String customerMerchantProfileId;
  late String cardNumber;
  late String cvv;
  late String expiryMonth;
  late String expiryYear;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  late String amount;
  String? signature;
  late String description;

  CreditCardRequestModel(
      {required this.merchantReferenceId,
      required this.customerMerchantProfileId,
      required this.cardNumber,
      required this.cvv,
      required this.expiryMonth,
      required this.expiryYear,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      required this.amount,
      this.signature,
      required this.description});

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
