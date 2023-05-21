import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/app_constant.dart';

class NotiApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late Map<String, String> _formHeader;
  SharedPreferences sharedPreferences;
  NotiApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30); //AppConstant.Token
    token = sharedPreferences.getString("token") ?? "";

    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': "key = ${AppConstant.serverKey}",
      "HttpHeaders.contentTypeHeader": "application/json",
      "Accept": "application/json"
    };
    _formHeader = {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
  }
  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri, headers: _mainHeaders);

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(
    String uri,
    dynamic body,
  ) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      // print(response.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postFormData(
    String uri,
    dynamic body,
  ) async {
    try {
      Response response = await post(uri, body, headers: _formHeader);
      // print(response.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(
    String uri,
  ) async {
    // print(body.toString());
    try {
      Response response = await delete(uri, headers: _mainHeaders);
      // print(response.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json",
      "Accept": "application/json"
    };
    _formHeader = {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
  }
}
