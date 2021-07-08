import 'package:formz/formz.dart';

enum CreditCardHolderNameError { empty, format }

extension errorMessage on CreditCardHolderNameError {
  String get message {
    switch (this) {
      case CreditCardHolderNameError.empty:
        return 'passwordEmptyError';
      case CreditCardHolderNameError.format:
        return 'invalidFormat';
      default:
        return '';
    }
  }
}

class CreditCardHolderName
    extends FormzInput<String, CreditCardHolderNameError> {
  const CreditCardHolderName.pure() : super.pure('');

  const CreditCardHolderName.dirty([String value = '']) : super.dirty(value);

  @override
  CreditCardHolderNameError? validator(String value) {
    if (value.trim().isEmpty) return CreditCardHolderNameError.empty;
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value))
      return CreditCardHolderNameError.format;

    return null;
  }
}
