import 'package:alien_mates/mgr/rest/interceptors/log_interceptor.dart';
import 'package:alien_mates/utils/common/constants.dart';
import "package:dio/dio.dart";

class ApiQueries {
  static const String querySearchUniv = "/search";
}

class ApiClient {
  String? token;
  String? contentType;
  String? additionalUrl;
  Map<String, dynamic>? queryParameters;

  ApiClient(
      {this.token, this.queryParameters, this.contentType, this.additionalUrl});

  Map<String, dynamic>? get headers {
    if (token != null) {
      return {
        "Authorization": "$token",
        "Content-Type": contentType ?? "application/json"
      };
    }
    return {"Content-Type": contentType ?? "application/json"};
  }

  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(loggerInterceptor);

    BaseOptions options = BaseOptions(
      baseUrl: additionalUrl ?? Constants.univListBaseUrl,
      headers: headers,
      queryParameters: queryParameters,
    );
    _dio.options = options;
    return _dio;
  }
}
