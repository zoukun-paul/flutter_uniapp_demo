import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_uniapp_demo/common/http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UniAPP {

  /// 开发环境禁用
  static Future<File?> downloadApp(String appId,
      {void Function(int count, int total)? progress}) async {
    var cacheDir = await getApplicationCacheDirectory();
    var wgtFile = new File(cacheDir.path+'/download/$appId.wgt');
    var download = await Dio().download(
        "http://192.168.0.107:9091/api/v1/buckets/uniapp/objects/download?prefix=$appId.wgt",
        wgtFile.path,
        onReceiveProgress: progress
    );
    return wgtFile;
  }

  /// 下载uniApp
  static Future<File?> downloadAppWithCache(String appId,
      {void Function(int count, int total)? progress}) async {
    var url = HttpApi.path("/download?prefix=$appId.wgt");
    var fileStream = CacheManager(Config(
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 10,
        DefaultCacheManager.key,
        fileService: SuffixFileService()
    )).getFileStream(url, withProgress: true);
    Completer<File?> completer = Completer<File?>();
    late File file;
    fileStream.listen((result) {
      if (result is DownloadProgress) {
        var totalSize = result.totalSize ?? 10000000;
        progress?.call(result.downloaded, totalSize);
      }
      if (result is FileInfo) {
        file = result.file;
        print("save file ${file.path} download uri $url");
      }
    }, onError: (e) {
      // 失败
      completer.complete(null);
    }, onDone: () {
      completer.complete(file);
    });
    return completer.future;
  }

  /// 打开uniApp
  static void openRemoteUniApp(String uniAppId, File file, {String? password, String? pagePath}){
    const channel = MethodChannel('UniMP_mini_apps');
    var param = {'AppID': uniAppId, "remote":true, "wgtFile":file.path, "password":password??'', "pagePath": pagePath};
    channel.invokeMethod("open",param);
  }

  /// 打开本地内嵌nuiApp
  static void openLocalUniApp(String uniAppId){
    const channel = MethodChannel('UniMP_mini_apps');
    channel.invokeMethod("open",{'AppID': uniAppId});
  }


}

class SuffixFileService extends FileService {
  final http.Client _httpClient;

  SuffixFileService({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) async {
    final req = http.Request('GET', Uri.parse(url));
    if (headers != null) {
      req.headers.addAll(headers);
    }
    final httpResponse = await _httpClient.send(req);
    var suffix = url.substring(url.lastIndexOf("."));
    return SuffixHttpGetResponse(httpResponse, suffix);
  }
}

class SuffixHttpGetResponse extends HttpGetResponse {
  String suffix;

  SuffixHttpGetResponse(super._response, this.suffix);

  @override
  String get fileExtension => suffix;
}
