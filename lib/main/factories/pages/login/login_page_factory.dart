import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../http/api_url_factory.dart';
import '../../../builders/builders.dart';
import '../../../../domain/usecases/index.dart';
import '../../../../data/usecases/index.dart';
import '../../../../infra/index.dart';
import '../../../../ui/pages/pages.dart';
import '../../../../validation/protocols/field_validation.dart';
import '../../../../validation/validators/validators.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../presentation/protocols/protocols.dart';

Widget makeLoginPage() {
  final presenter = GetXLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidationComposite(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
  return LoginPage(presenter);
}

Authentication makeRemoteAuthentication() {
  final client = Client();
  final httpAdapter = HttpAdapter(client);

  return RemoteAuthentication(
    httpClient: httpAdapter,
    url: makeApiUrl('login'),
  );
}

SaveCurrentAccount makeLocalSaveCurrentAccount() {
  final secureStorage = FlutterSecureStorage();
  final localStorageAdapter = LocalStorageAdapter(secureStorage: secureStorage);

  return LocalSaveCurrentAccount(saveSecureCacheStorage: localStorageAdapter);
}

Validation makeLoginValidationComposite() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}
