import 'package:equatable/equatable.dart';

//TODO set your user entity here
class FawryEntity extends Equatable {
  final bool? success;
  final int? statusCode;
  final String? statusDescription;
  final String? type;
  final String? paymentGatewayReferenceId;
  final String? merchantReferenceId;
  final int? cowpayReferenceId;

  FawryEntity(
      {this.success,
      this.statusCode,
      this.statusDescription,
      this.type,
      this.paymentGatewayReferenceId,
      this.merchantReferenceId,
      this.cowpayReferenceId});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
