abstract class CowpayException implements Exception {
  final _message;
  final _prefix;
  final code;

  CowpayException([this._message, this._prefix, this.code]);

  String toString() {
    return "$_prefix$_message, code:$code";
  }
}

class FetchDataException extends CowpayException {
  FetchDataException([String? message, int? code])
      : super(message, "Error During Communication: ", code);
}

class BadRequestException extends CowpayException {
  BadRequestException([String? message, int? code])
      : super(message, "Invalid Request: ", code);
}

class UnauthorisedException extends CowpayException {
  UnauthorisedException([String? message, int? code])
      : super(message, "Unauthorised: ", code);
}

class InvalidInputException extends CowpayException {
  InvalidInputException([String? message, int? code])
      : super(message, "Invalid Input: ", code);
}

class InternalServerException extends CowpayException {
  InternalServerException([String? message, int? code])
      : super(message, "Internal Server Error: ", code);
}
