import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_localization/multiple_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/shared_preferences_manager.dart';
import '../base/ultils/device_id_services.dart';
import '../generated/intl/messages_all.dart';
import '../generated/l10n.dart';
import '../network/network.dart';
import 'app_services.dart';
import 'base_module.dart';
import 'config_service.dart';
import 'http_services.dart';
import 'message_services.dart';
import 'navigation_service.dart';

abstract class Argument {
  factory Argument.fromMap(Map<String, dynamic> map) =>
      throw UnimplementedError();
  Map<String, dynamic> toMap();
}

class DefaultRoute {
  static Route<dynamic> notFound() => MaterialPageRoute<void>(
      builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found !'),
            ),
          ));

  static Widget splashScreen(Widget? screen) {
    if (screen != null) {
      return screen;
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Page not found.'),
        ),
      );
    }
  }
}

Route<dynamic> getPageRoute(Widget widget, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => widget, settings: settings);
}

class ModuleManagement {
  factory ModuleManagement() {
    return _singleton;
  }

  ModuleManagement._internal();
  static final ModuleManagement _singleton = ModuleManagement._internal();
  final List<BaseModule> _modules = <BaseModule>[];
  final GetIt serviceLocator = GetIt.instance;

  void addModules(List<BaseModule> modules) {
    _modules.addAll(modules);
  }

  List<BaseModule> getModules() => _modules;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final BaseModule module in _modules) {
      if ((Uri.parse(settings.name ?? '').path).contains(module.modulePath())) {
        return module.onGenerateRoute(settings);
      }
    }
    return DefaultRoute.notFound();
  }

  List<LocalizationsDelegate<dynamic>> localizationsDelegates() {
    final List<LocalizationsDelegate<dynamic>> result =
        <LocalizationsDelegate<dynamic>>[];
    result.addAll([
      MultiLocalizationsDelegate.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ]);

    for (final BaseModule module in _modules) {
      result.addAll(module.localizationsDelegates());
    }
    return result;
  }

  Future<void> injectDependencies() async {
    serviceLocator.registerLazySingleton(() => NavigationService());
    final sharedPreferences = await SharedPreferences.getInstance();
    serviceLocator.registerLazySingleton(
        () => SharedPreferencesManager(sharedPreferences: sharedPreferences));

    serviceLocator.registerLazySingleton(() => AppCubit(
        const AppState<AppTheme, AppLanguage>(
            appTheme: AppTheme.light, appLanguage: AppLanguage.vi)));

    serviceLocator.registerLazySingleton(() => MessageCenter());

    final config = ConfigService();
    serviceLocator.registerSingleton(config);

    // register Device ID service for get device id log
    serviceLocator.registerLazySingleton(() => DeviceIDService());

    String env = "";

    late Network network;
    if (config.isRelease == false) {
      if (env == Env.Pro.shortName()) {
        network = Network.prodNetwork();
      } else if (env == Env.Dev.shortName()) {
        network = Network.devNetwork();
      } else {
        network = Network.prodNetwork();
      }
    } else {
      network = Network.prodNetwork();
    }

    GetIt.instance.registerLazySingleton<Network>(
      () => network,
    );

    final Dio dio = await setupDio(network.domain.apiUrl);
    serviceLocator.registerLazySingleton<Dio>(() => dio);

    for (final BaseModule module in _modules) {
      module.injectServices(serviceLocator);
    }
  }
}

class MultiLocalizationsDelegate extends AppLocalizationDelegate {
  const MultiLocalizationsDelegate();

  static const AppLocalizationDelegate delegate = MultiLocalizationsDelegate();

  @override
  Future<ILanguage> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages, locale, (l) => ILanguage.load(locale),
        setDefaultLocale: true);
  }
}
