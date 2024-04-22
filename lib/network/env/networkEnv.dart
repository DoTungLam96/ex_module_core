abstract class NetworkEnv {
  /// Base url is base domain of application
  /// Using for dchart api, gen trading chart webview url,...
  /// Example: https://iboard-dev.ssi.com.vn for dev env
  String get baseUrl;

  /// API url is api domain of Rest APIs v2
  /// Example: https://api-dev-iboard.ssi.com.vn for dev env
  String get apiUrl;

  String get queryUrl;
  String get priceStream;
  String get txnStream;
  String get tAPIUrl;
  String get keypassUrl;
}
