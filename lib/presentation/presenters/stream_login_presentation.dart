import 'dart:async';
import 'package:flutter/foundation.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailError;
  String passwordError;
  bool isFormValid = false;
}

class StreamLoginPresenter {
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();
  final Validation validation;

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({@required this.validation});

  void dispose() {
    _controller.close();
  }

  void update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.emailError = this.validation.validate(field: 'email', value: email);
    update();
  }

  void validatePassword(String password) {
    _state.passwordError =
        this.validation.validate(field: 'password', value: password);
    update();
  }
}
