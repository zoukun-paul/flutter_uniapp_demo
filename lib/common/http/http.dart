
import 'package:dio/dio.dart';
import 'package:flutter_uniapp_demo/common/store/user_store.dart';

const String _tokenKey = "token";

class HttpApi {

  final _dio = Dio(BaseOptions(
    baseUrl: "http://127.0.0.1:8080/",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    // 响应content-type 为 [Headers.jsonContentType] 时自动解析为JSON对象
    responseType: ResponseType.json,
    // 状态码判定
    validateStatus:(code)=>code==200
  ))..interceptors.add(HttpHeaderInterceptor());

  /// get request
  Future<Response> get(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.get(
        path,
        data: null,
        queryParameters:queryParameters,
        options:options,
        cancelToken:cancelToken,
        onReceiveProgress:onReceiveProgress
    );
  }

  /// get request
  Future<Response> post(String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.post(
        path,
        data: null,
        queryParameters:queryParameters,
        options:options,
        cancelToken:cancelToken,
        onReceiveProgress:onReceiveProgress
    );
  }

}

/// header 填充
class HttpHeaderInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_tokenKey] = UserStore.token;
    super.onRequest(options, handler);
  }

}