import 'networkEnv.dart';

class ProEnv implements NetworkEnv {
  @override
  String get baseUrl => 'https://iboard.ssi.com.vn';

  @override
  String get apiUrl => "https://iboard-api.ssi.com.vn";

  @override
  String get priceStream => "wss://iboard-pushstream.ssi.com.vn/realtime";

  @override
  String get txnStream => "wss://txnstream-iboard.ssi.com.vn/realtime";

  @override
  String get queryUrl => "https://iboard-query.ssi.com.vn";

  @override
  String get tAPIUrl => "https://iboard-tapi.ssi.com.vn";

  @override
  String get keypassUrl => 'https://smartotp.ssi.com.vn/keypass.wsmobile/';
}
