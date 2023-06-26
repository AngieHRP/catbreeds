import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:catbreeds/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../utils/strings.dart';
import '../utils/connectivity/connectivity_adapter.dart';
import '../utils/connectivity/generic_error.dart';

@singleton
class ApiSource {
  final String baseUrl;
  final http.Client client;
  final Connectivity connectivity;

  final Duration timeout = const Duration(seconds: 30);

  ApiSource(
    @Named('baseUrl') this.baseUrl,
    this.client,
    this.connectivity,
  );


  Future<List<dynamic>> getService(
    Uri url) async {
    try {
      if (!await connectivity.isConnected()) {
        throw GenericError(errorMsg: 'Error de conexiòn', errorCode: "noInternet");
      }
      Map<String, String> headers = <String, String>{};
      headers['x-api-key'] = Constants.apiKey;
      final http.Response service = await client.get(url, headers: headers).timeout(timeout);
      log(url.toString(), name: 'url');
      List<dynamic> map = [];
      if (service.statusCode >= 200) {
        map = json.decode(service.body);
      } else {
        throw GenericError(
            errorMsg: Strings.errorGeneric,
            errorCode: "500");
      }
      return map;
    } catch (error) {
      if (error is GenericError) {
        throw GenericError(
            errorMsg: error.errorMsg,
            errorCode: error.errorCode);
      } else {
        throw GenericError(
            errorMsg: Strings.errorGeneric,
            errorCode: "500");
      }
    }
  }

}