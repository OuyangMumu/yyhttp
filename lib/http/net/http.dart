import 'package:dio/dio.dart';
import 'package:yyhttp/http/net/entry_http.dart';
export 'package:dio/dio.dart';

abstract class Http {
  static const String HTTP_DEFAULT_TAG = "default";

  factory Http() => createHttp();

  /// 数据解析器
  Map<String, DataParse> parses;

  Future<T> request<T>(String path, HttpType method, String tag,
      {data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});

  Future<T> get<T>(String path,
      {String tag,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});

  Future<T> post<T>(String path,
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});
  Future<T> put<T>(String path,
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});
  Future<T> delete<T>(String path,
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});
  Future<T> head<T>(String path,
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});
  Future<Response> download(String urlPath, savePath,
      {String tag,
      ProgressCallback onReceiveProgress,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options options,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});
  Future<T> patch<T>(String path,
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError});

  /// 添加请求客户端
  void addClient(Dio dio, {String tag = Http.HTTP_DEFAULT_TAG});

  /// 添加请求客户端
  void addClientUrl(String baseUrl, {String tag = Http.HTTP_DEFAULT_TAG});

  /// 获取客户端
  Dio getClient({String tag = Http.HTTP_DEFAULT_TAG});

  /// 设置全局客户端选项
  void setGlobalOptions(BaseOptions options);

  /// 移除全局客户端选项
  void removeGlobalOptions();

  /// 添加全局拦截器
  void addGlobalInterceptor(Interceptor interceptor);

  /// 删除全局拦截器
  void removeGlobalInterceptor(Interceptor interceptor);

  /// 添加解析器
  void addParse(DataParse dataParse, {tag = Http.HTTP_DEFAULT_TAG});

  /// 删除解析器
  ///
  void removeParse({DataParse dataParse, tag = Http.HTTP_DEFAULT_TAG});

  /// 获取解析器
  DataParse getParse({tag = Http.HTTP_DEFAULT_TAG});

  /// 转成相应对象
  T toEntity<T>(String data, String tag);
}

abstract class DataParse {
  T parse<T>(String data);
}

typedef HttpSuccessCallback = void Function(Response<String> res);
typedef HttpErrorCallback = void Function(
    int stsatusCode, String data, String errorMsg, dynamic e);
enum HttpType { GET, POST, PUT, DELETE, HEAD, DOWNLOAD, PATCH }
