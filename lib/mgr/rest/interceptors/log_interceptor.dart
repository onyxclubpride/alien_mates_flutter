import 'package:dio/dio.dart';
import 'dart:developer';

final loggerInterceptor =
    InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });
  log("┌------------------------------------------------------------------------------");
  log("| [DIO] Request: ${options.method} ${options.uri}");
  log("| ${options.data != null ? options.data.toString() : ''}");
  log("| Headers: $headers");
  log("├------------------------------------------------------------------------------");
  handler.next(options); //continue
}, onResponse: (Response response, handler) async {
  if (response.requestOptions.path != "v1/user/me/terms-and-conditions") {
    log("| [DIO] Response [code ${response.statusCode}]:${response.data.toString()}");
  } else {
    log("| [DIO] Response [code ${response.statusCode}]");
  }
  log("└------------------------------------------------------------------------------");
  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  log("| [DIO] Error: ${error.error}: ${error.response?.toString()}");
  log("└------------------------------------------------------------------------------");
  handler.next(error); //continue
});
