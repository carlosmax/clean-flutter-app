import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';

import '../protocols/protocols.dart';
import '../../domain/helpers/index.dart';
import '../../domain/usecases/index.dart';
import '../../domain/usecases/save_current_account.dart';
import '../../ui/pages/login/login_presenter.dart';

class GetXLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<String> get mainErrorStream => _mainError.stream;

  GetXLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  void dispose() {}

  void validateEmail(String email) {
    _email = email;
    _emailError.value = this.validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        this.validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  Future<void> auth() async {
    try {
      _isLoading.value = true;

      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));

      await saveCurrentAccount.save(account);
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }
}
