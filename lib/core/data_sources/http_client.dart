// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../models/success_response_model.dart';

class HttpService extends http.BaseClient {
  final RetryClient client;
  final List<String> unauthorizedRoutes;

  HttpService({
    required this.client,
    required this.unauthorizedRoutes,
  });

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    var response = super.get(
      url,
      headers: headers,
    );
    log((await response).body.toString(), name: "RESPONSE");
    var newResponse = await response;
    if (newResponse.statusCode == 403) {
      log('----------------------------- unVerified');
      var responseModel =
          SuccessResponseModel.fromJson(json.decode(newResponse.body));
    }
    return response;
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    log(body.toString(), name: "REQUEST_BODY");
    var response = super.post(url,
        body: body != null ? json.encode(body) : null,
        headers: headers,
        encoding: encoding);
    log((await response).body.toString(), name: "RESPONSE");
    var newResponse = await response;
    if (newResponse.statusCode == 403) {
      log('----------------------------- unVerified');
      var responseModel =
          SuccessResponseModel.fromJson(json.decode(newResponse.body));
    }
    return response;
  }

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    var response = super.put(url,
        body: body != null ? json.encode(body) : null,
        headers: headers,
        encoding: encoding);
    log((await response).body.toString(), name: "RESPONSE");
    var newResponse = await response;
    if (newResponse.statusCode == 403) {
      log('----------------------------- unVerified');
      var responseModel =
          SuccessResponseModel.fromJson(json.decode(newResponse.body));
    }
    return response;
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    var response = super.delete(url,
        body: body != null ? json.encode(body) : null,
        headers: headers,
        encoding: encoding);
    log((await response).body.toString(), name: "RESPONSE");
    var newResponse = await response;
    if (newResponse.statusCode == 403) {
      log('----------------------------- unVerified');
      var responseModel =
          SuccessResponseModel.fromJson(json.decode(newResponse.body));
    }
    return response;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.update('Accept', (_) => 'application/json',
        ifAbsent: () => 'application/json');
    request.headers.update('Content-Type', (_) => 'application/json',
        ifAbsent: () => 'application/json');
    late http.StreamedResponse response;
    log(request.toString(), name: 'REQUEST');
    bool unAuth = false;
    log(
        request.url.path
            .replaceAll(RegExp(r"[0-9]+/"), "")
            .replaceAll('/api', "")
            .replaceFirst("/", ""),
        name: "PATH");
    for (String uR in unauthorizedRoutes) {
      if (request.url.path
              .replaceAll(RegExp(r"[0-9]+/"), "")
              .replaceAll('/api', "")
              .replaceFirst("/", "") ==
          uR) {
        response = await sendUnauthenticated(request);
        unAuth = true;
      }
    }
    if (!unAuth) {}
    log(response.statusCode.toString(), name: 'STATUS_CODE');
    if (response.statusCode == 502) {
      log('----------------------------- server is updating now');
    } else if (response.statusCode == 401) {
      log('----------------------------- unAuthenticated');
      try {} catch (e) {
        log(e.toString());
      } finally {}
      // throw ServerException(message: "something went wrong");
    }
    return response;
  }

  Future<http.StreamedResponse> sendUnauthenticated(
      http.BaseRequest request) async {
    var response = await client.send(request);
    return response;
  }
}
