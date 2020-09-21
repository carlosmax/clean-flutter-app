import 'package:flutter/foundation.dart';

import '../entities/account.dart';

abstract class Authentication {
  Future<Account> auth({@required String email, @required String password});
}
