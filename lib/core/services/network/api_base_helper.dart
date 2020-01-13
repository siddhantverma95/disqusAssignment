import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';
import 'dio_config.dart';

class ApiBaseHelper {
  Future<dynamic> getRequest(String url, Map<String, dynamic> queryParams) async {
    var responseJson;
    Dio _dio = createDio();
    Dio _dioInterceptor = addInterceptors(_dio);
    //_dioInterceptor = addTokenInterceptor(_dioInterceptor);
    try {
      final response =
          await _dioInterceptor.get(url, queryParameters: queryParams);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection.');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic params, dynamic data}) async {
    var responseJson;
    Dio _dio = createDio();
    Dio _dioInterceptor = addInterceptors(_dio);
    try {
      Response response =
          await _dioInterceptor.post(url, data: data, queryParameters: params);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection.');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        //var responseJson = json.decode(response.data);
        return response;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
