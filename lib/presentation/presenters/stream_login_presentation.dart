import 'dart:async';
import 'package:flutter/foundation.dart';

import '../protocols/protocols.dart';

class StreamLoginPresenter {
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();
  final Validation validation;

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  StreamLoginPresenter({@required this.validation});

  void dispose() {
    _controller.close();
  }

  void validateEmail(String email) {
    _state.emailError = this.validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

class LoginState {
  String emailError;
}