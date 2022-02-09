import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  bool? success;
  int? statusCode;
  String? statusDescription;
  String? type;
  bool? threeDSecured;
  String? paymentGatewayReferenceId;
  String? merchantReferenceId;
  int? cowpayReferenceId;

  CreditCardEntity(
      {this.success,
      this.statusCode,
      this.statusDescription,
      this.type,
      this.threeDSecured,
      this.paymentGatewayReferenceId,
      this.merchantReferenceId,
      this.cowpayReferenceId});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
