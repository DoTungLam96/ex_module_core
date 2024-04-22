// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class ILanguage {
  ILanguage();

  static ILanguage? _current;

  static ILanguage get current {
    assert(_current != null,
        'No instance of ILanguage was loaded. Try to initialize the ILanguage delegate before accessing ILanguage.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ILanguage> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ILanguage();
      ILanguage._current = instance;

      return instance;
    });
  }

  static ILanguage of(BuildContext context) {
    final instance = ILanguage.maybeOf(context);
    assert(instance != null,
        'No instance of ILanguage present in the widget tree. Did you add ILanguage.delegate in localizationsDelegates?');
    return instance!;
  }

  static ILanguage? maybeOf(BuildContext context) {
    return Localizations.of<ILanguage>(context, ILanguage);
  }

  /// `Đăng Nhập`
  String get login {
    return Intl.message(
      'Đăng Nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get username {
    return Intl.message(
      'Tên đăng nhập',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng bạn trở lại`
  String get welcome {
    return Intl.message(
      'Chào mừng bạn trở lại',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống đang xảy ra lỗi, Xin vui lòng đợi trong ít phút.`
  String get maintenance_message {
    return Intl.message(
      'Hệ thống đang xảy ra lỗi, Xin vui lòng đợi trong ít phút.',
      name: 'maintenance_message',
      desc: '',
      args: [],
    );
  }

  /// `Đây là bản base flutter đang trong quá trình hoàn thiện`
  String get flutter_copyright {
    return Intl.message(
      'Đây là bản base flutter đang trong quá trình hoàn thiện',
      name: 'flutter_copyright',
      desc: '',
      args: [],
    );
  }

  /// `Chọn giao diện`
  String get choose_theme {
    return Intl.message(
      'Chọn giao diện',
      name: 'choose_theme',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngôn ngữ`
  String get choose_language {
    return Intl.message(
      'Chọn ngôn ngữ',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ILanguage> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ILanguage> load(Locale locale) => ILanguage.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
