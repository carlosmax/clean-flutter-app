import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String token;

  List get props => [token];

  Account(this.token);
}
