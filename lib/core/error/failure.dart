abstract class Failure {
  final String? message;

  Failure({this.message = 'something went wrong'});
}

//General Failures

class ServerFailure extends Failure {
  ServerFailure({
    String? message,
  }) : super(message: message);
}

class ParsingFailure extends Failure {
  ParsingFailure() : super(message: "Parsing failure");
}

class CacheFailure extends Failure {
  CacheFailure() : super(message: "Caching failure");
}
