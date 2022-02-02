import 'package:flutter/material.dart';

abstract class CowpayEvent {
  const CowpayEvent();
}

class ChangeTabCurrentIndexEvent extends CowpayEvent {
  final int index;

  ChangeTabCurrentIndexEvent(this.index);
}

class ChargeCreditCardValidation extends CowpayEvent {
  const ChargeCreditCardValidation(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [];
}

class ChargeFawry extends CowpayEvent {
  const ChargeFawry(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [];
}
