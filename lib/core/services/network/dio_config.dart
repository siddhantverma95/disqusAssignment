import 'package:dio/dio.dart';
import 'package:flutter_assign/utils/api_constants.dart';

Dio createDio() {
  return Dio(
    BaseOptions(
      connectTimeout: 6000,
      receiveTimeout: 6000,
      baseUrl: BASE_URL,
    )
  );
}

Dio addInterceptors(Dio dio) {
  return dio..interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) => requestInterceptor(options),
      onResponse: (Response response) => responseInterceptor(response),
      onError: (DioError dioError) => errorInterceptor(dioError)));
}

void requestInterceptor(RequestOptions options) async{
  print("REQUEST QUERY: ${options.queryParameters.toString()}");
  print("REQUEST PATH: ${options.path}");
}

void responseInterceptor(Response response){
  print("RESPONSE OPTIONS: $response");
}

void errorInterceptor(DioError dioError){
  print("ERROR: ${dioError.error.toString()} ERROR MESSAGE: ${dioError.message}");
}