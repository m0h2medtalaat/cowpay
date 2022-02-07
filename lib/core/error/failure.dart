import 'package:equatable/equatable.dart';

abstract class Failure {

}

//General Failures

class ServerFailure extends Failure{}

class ParsingFailure extends Failure{}

class CacheFailure extends Failure{}