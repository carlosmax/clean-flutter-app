import 'package:ForDev/data/usecases/remote_authentication.dart';
import 'package:ForDev/infra/http/index.dart';
import 'package:ForDev/main/factories/http/api_url_factory.dart';
import 'package:ForDev/presentation/presenters/stream_login_presentation.dart';
import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Widget makeLoginPage() {
  //TODO: separate factories in files

  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteAuthentication = RemoteAuthentication(
    httpClient: httpAdapter,
    url: makeApiUrl('login'),
  );
  final validationComposite = ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
  final presenter = StreamLoginPresenter(
    authentication: remoteAuthentication,
    validation: validationComposite,
  );
  return LoginPage(presenter);
}
