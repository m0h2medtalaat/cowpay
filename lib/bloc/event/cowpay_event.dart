abstract class CowpayEvent {
  const CowpayEvent();
}

class ChangeTabCurrentIndexEvent extends CowpayEvent {
  final int index;

  ChangeTabCurrentIndexEvent(this.index);
}
