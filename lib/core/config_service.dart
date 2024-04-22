class ConfigService {
  String get flavorName {
    return const String.fromEnvironment('app.flavor');
  }

  bool get isForAuto {
    return const String.fromEnvironment('environment') == 'auto';
  }

  bool get isRelease {
    return const bool.fromEnvironment('release');
  }
}
