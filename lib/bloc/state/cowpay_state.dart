import 'package:equatable/equatable.dart';

class CowpayState extends Equatable {
  const CowpayState({this.tabCurrentIndex = 0});

  final int tabCurrentIndex;

  CowpayState copyWith({int? tabCurrentIndex}) {
    return CowpayState(
        tabCurrentIndex: tabCurrentIndex ?? this.tabCurrentIndex);
  }

  @override
  List get props => [tabCurrentIndex];
}
