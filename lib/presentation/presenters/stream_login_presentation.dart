import 'dart:async';
import 'package:flutter/foundation.dart';

import '../protocols/protocols.dart';
import '../../domain/usecases/index.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  bool isLoading = false;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter {
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();
  final Validation validation;
  final Authentication authentication;

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  StreamLoginPresenter(
      {@required this.validation, @required this.authentication});

  void dispose() {
    _controller.close();
  }

  void update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = this.validation.validate(field: 'email', value: email);
    update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        this.validation.validate(field: 'password', value: password);
    update();
  }

  Future<void> auth() async {
    _state.isLoading = true;
    update();
    await authentication.auth(
        AuthenticationParams(email: _state.email, secret: _state.password));
    _state.isLoading = false;
    update();
  }
}
