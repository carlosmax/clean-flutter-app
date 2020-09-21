import 'package:flutter/foundation.dart';

import '../http/index.dart';
import '../../domain/entities/index.dart';
import '../../domain/helpers/index.dart';
import '../../domain/usecases/index.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<Account> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse = await this
          .httpClient
          .request(url: this.url, method: 'post', body: body);

      return Account.fromJson(httpResponse);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': this.email, 'password': this.password};
}
