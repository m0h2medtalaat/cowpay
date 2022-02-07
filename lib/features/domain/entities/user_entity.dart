import 'package:equatable/equatable.dart';
//TODO set your user entity here
class UserEntity extends Equatable{
  final String name;
  final String email;
  final String age;

  UserEntity({required this.name, required  this.email, required  this.age});

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

