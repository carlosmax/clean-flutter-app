import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'package:ForDev/data/usecases/remote_authentication.dart';
import 'package:ForDev/infra/http/index.dart';
import 'package:ForDev/main/factories/http/api_url_factory.dart';
import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/validation/protocols/protocols.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:ForDev/presentation/presenters/presenters.dart';
import 'package:ForDev/main/builders/builders.dart';

Widget makeLoginPage() {
  //TODO: separate factories in files

  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteAuthentication = RemoteAuthentication(
    httpClient: httpAdapter,
    url: makeApiUrl('login'),
  );
  final validationComposite = ValidationComposite(makeLoginValidations());
  final presenter = GetXLoginPresenter(
    authentication: remoteAuthentication,
    validation: validationComposite,
  );
  return LoginPage(presenter);
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}
