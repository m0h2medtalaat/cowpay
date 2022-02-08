class ServerException implements Exception {}

class CacheException implements Exception {}

class ParsingException implements Exception {}

class BadRequestException implements Exception {}

class InternalServerException implements Exception {}

class AuthException implements Exception {}

class UnExpectedException implements Exception {
  final String? message;

  UnExpectedException({this.message = ""});
}
