import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import '../../constants/contants.dart';
import '../../generated/l10n.dart';
import 'api_error_model.dart';
import 'exceptions/api_exception.dart';

class HandleErrorInterceptor extends Interceptor {
  HandleErrorInterceptor({this.errorTokenExpire});

  final VoidCallback? errorTokenExpire;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.responseType = ResponseType.json;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final apiException = await err.toApiException();
    err.error = apiException;
    if (apiException.statusCode == 503) {
      err.response = null;
    }

    if (apiException.statusCode == 401 || apiException.code == 'ERR_AUTH_401') {
      //show dialog login
      if (IGNORE_AUTH_401.contains(err.error.path.toString())) {
        handler.next(err);
      } else {
        errorTokenExpire?.call();
      }
    } else {
      handler.next(err);
    }
  }
}

extension on DioError {
  Future<ApiException> toApiException() async {
    final errorCode = response?.statusCode ?? 0;
    final path = response?.requestOptions.uri.path ?? '';

    if (errorCode == 503) {
      return ApiException.internalServerError(
          path, ILanguage.current.maintenance_message, '$errorCode', errorCode);
    }

    final apiError = APIError.fromJson(response?.data);
    switch (errorCode) {
      case 400:
        return ApiException.badRequest(
            path,
            apiError.message ?? ILanguage.current.maintenance_message,
            apiError.code,
            errorCode);
      case 401:
        return ApiException.unauthorized(
            path,
            apiError.message ?? ILanguage.current.maintenance_message,
            apiError.code,
            errorCode);
      case 403:
        return ApiException.forbidden(
            path,
            apiError.message ?? ILanguage.current.maintenance_message,
            apiError.code,
            errorCode);
      case 404:
        return ApiException.notFound(
            path,
            apiError.message ?? ILanguage.current.maintenance_message,
            apiError.code,
            errorCode);
      case 500:
        return ApiException.internalServerError(
            path,
            apiError.message ?? ILanguage.current.maintenance_message,
            apiError.code,
            errorCode);
      default:
        final connectivity = await Connectivity().checkConnectivity();

        if (connectivity == ConnectivityResult.none) {
          return ApiException.noConnection(
              path, ILanguage.current.maintenance_message, '', 0);
        }
        return ApiException.noConnection(
            path, ILanguage.current.maintenance_message, '', 0);
    }
  }
}

extension on DioError {
  String toMessage() {
    return (error as ApiException).message ?? '';
  }
}
