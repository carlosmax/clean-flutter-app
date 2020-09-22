import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../data/http/index.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await this.client.post(url, headers: headers, body: jsonBody);

    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    return response.statusCode == 200 && response.body.isNotEmpty
        ? jsonDecode(response.body)
        : null;
  }
}
