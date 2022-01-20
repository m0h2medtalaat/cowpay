import 'package:cowpay/bloc/event/cowpay_event.dart';
import 'package:cowpay/bloc/state/cowpay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowpayBloc extends Bloc<CowpayEvent, CowpayState> {
  CowpayBloc() : super(CowpayState());

  @override
  Stream<CowpayState> mapEventToState(CowpayEvent event) async* {
    if (event is ChangeTabCurrentIndexEvent) {
      yield _changeTabCurrentIndexToState(event);
    }
  }

  CowpayState _changeTabCurrentIndexToState(ChangeTabCurrentIndexEvent event) {
    return state.copyWith(tabCurrentIndex: event.index);
  }
}
