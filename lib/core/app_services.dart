import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/shared_preferences_manager.dart';
import '../base/ultils/pair.dart';
import '../constants/contants.dart';

enum AppTheme {
  light,
  dark,
}

extension AppThemeEx on AppTheme {
  bool get isDark => this == AppTheme.dark;

  String get keyValue {
    if (this == AppTheme.dark) {
      return 'dark';
    }
    return 'light';
  }

  static AppTheme fromValue(String? value) {
    if (value == AppTheme.dark.keyValue) {
      return AppTheme.dark;
    }
    return AppTheme.light;
  }
}

enum AppLanguage { en, vi }

extension AppLanguageEx on AppLanguage {
  bool get isEnglish => this == AppLanguage.en;

  String get keyValue {
    switch (this) {
      case AppLanguage.vi:
        return 'vi';
      default:
        return 'en';
    }
  }

  String get displayName {
    switch (this) {
      case AppLanguage.vi:
        return 'Tiếng Việt';
      case AppLanguage.en:
        return 'English';
      default:
        return '';
    }
  }
}

class AppState<T extends AppTheme, V extends AppLanguage> extends Equatable {
  const AppState({required this.appLanguage, required this.appTheme});

  final T appTheme;
  final V appLanguage;

  @override
  List<Object?> get props => <Object?>[appTheme, appLanguage];
}

class AppCubit extends Cubit<AppState<AppTheme, AppLanguage>> {
  AppCubit(AppState<AppTheme, AppLanguage> appState)
      : super(const AppState<AppTheme, AppLanguage>(
            appTheme: AppTheme.light, appLanguage: AppLanguage.vi));
  final SharedPreferencesManager _sharedPreferencesManager =
      GetIt.instance.get();

  String _themeToString(AppTheme theme) {
    return theme.keyValue;
  }

  String langToString(AppLanguage language) {
    return language.keyValue;
  }

  Pair getDefault() {
    AppLanguage defaultLanguage = AppLanguage.en;
    final currentLocale = Platform.localeName;
    if (currentLocale.contains('vi')) {
      defaultLanguage = AppLanguage.vi;
    }

    final String _language = _sharedPreferencesManager.getString(kLanguage) ??
        defaultLanguage.keyValue;
    final String themValue =
        _sharedPreferencesManager.getString(kTheme) ?? AppTheme.light.keyValue;
    final theme = AppThemeEx.fromValue(themValue);

    AppLanguage language = AppLanguage.en;
    if (_language == AppLanguage.vi.keyValue) {
      language = AppLanguage.vi;
    }
    return Pair(language, theme);
  }

  void saveLanguage(String langCode) {
    _sharedPreferencesManager.putString(kLanguage, langCode);
  }

  Future<bool> saveTheme(String langCode) {
    return SharedPreferences.getInstance().then((SharedPreferences shared) {
      return shared.setString(kTheme, langCode);
    });
  }

  void changeTheme({required AppTheme theme}) {
    saveTheme(_themeToString(theme));
    emit(AppState<AppTheme, AppLanguage>(
        appTheme: theme, appLanguage: state.appLanguage));
  }

  void changeLanguage({required AppLanguage language}) {
    saveLanguage(langToString(language));
    emit(AppState<AppTheme, AppLanguage>(
        appLanguage: language, appTheme: state.appTheme));
  }

  void applySetting({required AppTheme theme, required AppLanguage language}) {
    emit(AppState<AppTheme, AppLanguage>(
        appLanguage: language, appTheme: theme));
  }
}
