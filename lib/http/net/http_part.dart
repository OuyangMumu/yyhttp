import 'package:dio/native_imp.dart';

import 'http.dart';
import 'package:dio/dio.dart';

class HttpPart implements Http {
  HttpPart._();
  static final HttpPart _instance = HttpPart._();
  factory HttpPart() => _instance;
  var _net = Net();
  @override
  Map<String, DataParse> parses = Map();

  @override
  Future<T> delete<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) async {
    return request<T>(path, HttpType.DELETE, tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<Response> download(String urlPath, savePath,
      {String tag = Http.HTTP_DEFAULT_TAG,
      onReceiveProgress,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options options,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    try {
      var response = _net.client(tag: tag).download(urlPath, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          deleteOnError: deleteOnError,
          lengthHeader: lengthHeader,
          data: data,
          options: options);
      return _parseAbsResponse(response, tag, onSuccess);
    } catch (e, r) {
      print(r);
      _callError(e, onError);
    }
    return Future.value(null);
  }

  @override
  Future<T> get<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return request<T>(path, HttpType.GET, tag,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<T> head<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return request<T>(path, HttpType.HEAD, tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<T> patch<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return request<T>(path, HttpType.PATCH, tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<T> post<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return request<T>(path, HttpType.POST, tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<T> put<T>(String path,
      {String tag = Http.HTTP_DEFAULT_TAG,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      onSendProgress,
      onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return request<T>(path, HttpType.PUT, tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  @override
  Future<T> request<T>(String path, HttpType method, String tag,
      {data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      onSendProgress,
      onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) async {
    Future<Response<String>> response;
    tag = tag ?? Http.HTTP_DEFAULT_TAG;

    try {
      switch (method) {
        case HttpType.DELETE:
          response = _net.client(tag: tag).delete(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken);

          break;
        case HttpType.GET:
          response = _net.client(tag: tag).get<String>(path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress);
          break;
        case HttpType.POST:
          response = _net.client(tag: tag).post<String>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress);
          break;
        case HttpType.PUT:
          response = _net.client(tag: tag).put<String>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress);
          break;
        case HttpType.HEAD:
          response = _net.client(tag: tag).head<String>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken);
          break;
        case HttpType.DOWNLOAD:
          break;
        case HttpType.PATCH:
          response = _net.client(tag: tag).patch<String>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress);
          break;
      }
      return await _parseResponse<T>(response, tag, onSuccess);
    } catch (e, r) {
      // print(r);
      _callError(e, onError);
    }
    return Future.value(null);
  }

  void _callError(dynamic e, HttpErrorCallback onError) {
    if (onError != null) {
      if (e is DioError) {
        DioError error = e;
        onError(error.response?.statusCode ?? -1, error.response?.data ?? "",
            error.message ?? "", e);
      } else {
        onError(-1, "", "error", e);
      }
    } else {
      throw e;
    }
  }

  Future<Response> _parseAbsResponse(Future<Response> response,
      String clientTag, HttpSuccessCallback onSuccess) async {
    if (onSuccess != null) {
      response.then((value) {
        onSuccess(value);
      });
    }
    Response res = await response;
    return res;
  }

  Future<T> _parseResponse<T>(Future<Response<String>> response,
      String clientTag, HttpSuccessCallback onSuccess) async {
    if (onSuccess != null) {
      response.then((value) {
        onSuccess(value);
      });
    }

    Response res = await response;
    var data = res.data;

    return toEntity<T>(data, clientTag);
  }

  /*
  * 添加解析器 
  */
  @override
  void addParse(DataParse dataParse, {tag = Http.HTTP_DEFAULT_TAG}) {
    parses[tag] = dataParse;
  }

  /*
   * 删除解析器 
   */
  @override
  void removeParse({DataParse dataParse, tag = Http.HTTP_DEFAULT_TAG}) {
    parses.removeWhere((key, value) => dataParse == value);
  }

  /*
  * 获取解析器
  */
  @override
  DataParse getParse({tag = Http.HTTP_DEFAULT_TAG}) {
    return parses[tag];
  }

  /*
   * 转成相应对象 
   */
  @override
  T toEntity<T>(String data, String clientTag) {
    var parse = parses[clientTag];

    if (T.toString() == "dynamic" ||
        T.toString() == "String" ||
        parses == null) {
      return data as T;
    }
    if (parse == null) {
      throw Exception("No parser found");
    }

    return parse.parse<T>(data);
  }

  @override
  void addClient(Dio dio, {tag = Http.HTTP_DEFAULT_TAG}) {
    _net.addClient(dio, tag: tag);
  }

  @override
  void addClientUrl(String baseUrl, {String tag = Http.HTTP_DEFAULT_TAG}) {
    _net.addClientUrl(baseUrl, clientTag: tag);
  }

  @override
  void addGlobalInterceptor(Interceptor interceptor) {
    _net.addGlobalInterceptor(interceptor);
  }

  @override
  void removeGlobalInterceptor(Interceptor interceptor) {
    _net.removeGlobalInterceptor(interceptor);
  }

  @override
  void removeGlobalOptions() {
    _net.removeGlobalOptions();
  }

  @override
  void setGlobalOptions(BaseOptions options) {
    _net.setGlobalOptions(options);
  }

  @override
  Dio getClient({tag = Http.HTTP_DEFAULT_TAG}) {
    return _net.client(tag: tag);
  }
}

class Net {
  var _clients = Map<String, Dio>();
  var _globalInterceptor = List<Interceptor>();
  BaseOptions _globalOptions;
  Net._() {
    addClient(_newDefaultDio());

  }

  static final Net _instance = Net._();
  factory Net() => _instance;

  void addClient(Dio dio, {String tag = Http.HTTP_DEFAULT_TAG}) {
    _clients[tag] = dio;
    if (_globalOptions != null) {
      dio.options = _globalOptions;
    }
    _globalInterceptor.forEach((element) {
      dio.interceptors.add(element);
    });
  }

  void addClientUrl(String baseUrl, {String clientTag}) {
    if (!baseUrl.endsWith("/")) {
      baseUrl = "$baseUrl/";
    }
    var dio = _newDefaultDio(baseUrl: baseUrl);
    addClient(dio, tag: clientTag);
  }

  void setGlobalOptions(BaseOptions options,
      {String tag = Http.HTTP_DEFAULT_TAG}) {
    this._globalOptions = options;
    _clients.forEach((key, value) {
      value.options = _globalOptions;
    });
  }

  void removeGlobalOptions({String tag = Http.HTTP_DEFAULT_TAG}) {
    this._clients.forEach((key, value) {
      if (value.options == this._globalOptions) {
        value.options = null;
      }
    });
    this._globalOptions = null;
  }

  /*
  * 添加全局拦截器 
  */
  void addGlobalInterceptor(Interceptor interceptor) {
    _globalInterceptor.add(interceptor);
    _clients.forEach((key, value) {
      value.interceptors.add(interceptor);
    });
  }

  /*
  * 删除全局拦截器
  */
  void removeGlobalInterceptor(Interceptor interceptor) {
    _globalInterceptor.remove(interceptor);
    _clients.forEach((key, value) {
      value.interceptors.remove(interceptor);
    });
  }

  Dio client({String tag = Http.HTTP_DEFAULT_TAG}) {
    return _clients[tag];
  }

  Dio _newDefaultDio({String baseUrl = ""}) {
    var http = HttpExploit();
    if (baseUrl.isNotEmpty) {
      http.options.baseUrl = baseUrl;
    }

    return http;
  }
}

class HttpExploit extends DioForNative {
  HttpExploit([BaseOptions options]) : super(options) {
    this.options.connectTimeout = 5000;
    this.options.receiveTimeout = 3000;
    this.options.responseType = ResponseType.json;
  }
}
