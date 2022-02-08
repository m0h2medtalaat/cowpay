import 'package:cowpay/core/error/exceptions.dart';
import 'package:cowpay/core/error/failure.dart';

class FailureHandler {
  final Exception exception;

  FailureHandler(this.exception);

  //TODO add failure messages
  Failure getExceptionFailure() {
    switch (exception.runtimeType) {
      case ServerException:
        ServerFailure();
        break;
      case CacheException:
        break;
      case ParsingException:
        ParsingFailure();
        break;
      case BadRequestException:
        ServerFailure();
        break;
      case InternalServerException:
        ServerFailure();
        break;
      case AuthException:
        ServerFailure();
        break;
      case UnExpectedException:
        UnExpectedException ex = exception as UnExpectedException;
        ServerFailure(message: ex.message);
        break;
      case FormatException:
        ParsingFailure();
        break;
      default:
        break;
    }
    return ServerFailure();
  }
}
