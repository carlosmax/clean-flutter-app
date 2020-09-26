import 'dart:async';
import 'package:ForDev/ui/pages/login/login_presenter.dart';
import 'package:flutter/foundation.dart';

import '../protocols/protocols.dart';
import '../../domain/usecases/index.dart';
import '../../domain/helpers/index.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  String mainError;
  bool isLoading = false;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final _state = LoginState();
  final Validation validation;
  final Authentication authentication;

  var _controller = StreamController<LoginState>.broadcast();
  
  Stream<String> get emailErrorStream =>
      _controller?.stream?.map((state) => state.emailError)?.distinct();

  Stream<String> get passwordErrorStream =>
      _controller?.stream?.map((state) => state.passwordError)?.distinct();

  Stream<bool> get isFormValidStream =>
      _controller?.stream?.map((state) => state.isFormValid)?.distinct();

  Stream<bool> get isLoadingStream =>
      _controller?.stream?.map((state) => state.isLoading)?.distinct();

  Stream<String> get mainErrorStream =>
      _controller?.stream?.map((state) => state.mainError)?.distinct();

  StreamLoginPresenter(
      {@required this.validation, @required this.authentication});

  void dispose() {
    _controller.close();
    _controller = null;
  }

  void update() => _controller?.add(_state);

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
    try {
      await authentication.auth(
          AuthenticationParams(email: _state.email, secret: _state.password));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }
    _state.isLoading = false;
    update();
  }
}
