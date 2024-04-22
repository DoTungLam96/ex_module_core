import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../base/shared_preferences_manager.dart';
import '../base/ultils/device_id_services.dart';
import '../constants/contants.dart';

Future<Dio> setupDio(String baseUrl) async {
  final options = BaseOptions(
    connectTimeout: 120000,
    receiveTimeout: 120000,
    responseType: ResponseType.json,
    // validateStatus: (status) {
    //   return true;
    // },
    baseUrl: baseUrl,
  );
  final Dio dio = Dio(options);

  dio.options.headers["content-type"] = 'application/json';
  final info = await PackageInfo.fromPlatform();
  dio.interceptors.add(AppInfoInterceptor(info));
  dio.interceptors.add(AuthInterceptor());
  return dio;
}

class AppInfoInterceptor extends Interceptor {
  AppInfoInterceptor(this.info);

  final PackageInfo info;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers['x-app'] = info.appName;
      options.headers['x-version'] = info.version;
      if (Platform.isAndroid) {
        options.headers['x-platform'] = "Android";
      }
      if (Platform.isIOS) {
        options.headers['x-platform'] = "iOS";
      }

      final SharedPreferences _shared = await SharedPreferences.getInstance();
      options.headers['accept-language'] = _shared.get(kLanguage) ?? "vi";
      options.headers['x-theme'] = _shared.get(kTheme) ?? "dark";

      if (SAS_API_PATHS.contains(options.path.toString())) {
        final deviceId =
            await GetIt.instance.get<DeviceIDService>().getDeviceID();
        options.headers['device-id'] = deviceId;
        options.headers['channel'] = APP_CHANNEL;
      }
    } catch (e) {
      if (kDebugMode) {
        print('CurlInterceptor AppInfoInterceptor error: $e');
      }
    }

    super.onRequest(options, handler);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains("login") ||
        options.path.contains("change-password") ||
        options.path.contains("reset-password") ||
        options.path.contains("exchange-biometric-token") ||
        options.path.contains("register-fingerprint")) {
      if (Platform.isAndroid) {
        options.headers['User-Agent'] = "okhttp/3.12.12 (android)";
      }
      if (Platform.isIOS) {
        options.headers['User-Agent'] =
            "iBoard/38 CFNetwork/1333.0.4 Darwin/21.5.0 (ios)";
      }
    }
    final token = GetIt.instance
        .get<SharedPreferencesManager>()
        .getString(KEY_ACCESS_TOKEN);
    if (options.baseUrl.contains("ssi") && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      print("statusCode ${response.statusCode}");
    }
    super.onResponse(response, handler);
  }
}
