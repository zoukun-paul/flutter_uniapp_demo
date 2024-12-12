
import 'package:dio/dio.dart';
import 'package:flutter_uniapp_demo/common/store/user_store.dart';

const String _tokenKey = "token";

class HttpApi {

  static Dio get dio => _dio;

  // static String baseUrl = "http://58.87.88.132:5000/";
  static String baseUrl = "http://192.168.0.107:9090/api/v1/buckets/uniapp/objects";

  static String path(String uri){
    if(uri.startsWith("/")){
      uri = uri.replaceFirst("/", "");
    }
    if(baseUrl.startsWith("/")){
      return "$baseUrl$uri";
    }
    return "$baseUrl/$uri";
  }

  static final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    // 响应content-type 为 [Headers.jsonContentType] 时自动解析为JSON对象
    responseType: ResponseType.json,
    // 状态码判定
    validateStatus:(code)=>code==200
  ))..interceptors.add(HttpHeaderInterceptor());

  /// get request
  static Future<Response> get(String path, {
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
  static Future<Response> post(String path, {
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