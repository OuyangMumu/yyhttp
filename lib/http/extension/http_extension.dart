import 'package:yyhttp/http/net/http.dart';

extension HttpExtension on String {
  Future<T> request<T>(HttpType method, String tag,
      {data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().request<T>(this, method, tag,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> get<T>(
      {String tag,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().get<T>(this,
        tag: tag,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> post<T>(
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().post<T>(this,
        tag: tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> put<T>(
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().put<T>(this,
        tag: tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> delete<T>(
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().delete<T>(this,
        tag: tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> head<T>(
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().head<T>(this,
        tag: tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<Response> download(savePath,
      {String tag,
      ProgressCallback onReceiveProgress,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options options,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().download(this, savePath,
        tag: tag,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<T> patch<T>(
      {String tag,
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      HttpSuccessCallback onSuccess,
      HttpErrorCallback onError}) {
    return Http().patch<T>(this,
        tag: tag,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        onSuccess: onSuccess,
        onError: onError);
  }
}
