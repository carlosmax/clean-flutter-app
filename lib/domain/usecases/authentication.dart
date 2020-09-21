import 'package:flutter/foundation.dart';

import '../entities/account.dart';

abstract class Authentication {
  Future<Account> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});

  Map toJson() => {'email': this.email, 'password': this.secret};
}
