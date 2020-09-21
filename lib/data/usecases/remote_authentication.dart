import 'package:flutter/foundation.dart';

import '../http/http_client.dart';
import '../../domain/usecases/index.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    this.httpClient.request(url: this.url, method: 'post', body: params.toJson());
  }
}