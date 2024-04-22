import 'networkEnv.dart';

class DevEnv implements NetworkEnv {
  @override
  String get baseUrl => 'https://iboard-dev.ssi.com.vn';

  @override
  String get apiUrl => 'https://iboard-api-dev.ssi.com.vn';

  @override
  String get priceStream => "wss://iboard-pushstream-dev.ssi.com.vn/realtime";

  @override
  String get txnStream => "wss://txnstream-dev-iboard.ssi.com.vn/realtime";

  @override
  String get queryUrl => "https://iboard-query-dev.ssi.com.vn";

  @override
  String get tAPIUrl => 'https://iboard-tapi-dev.ssi.com.vn';

  @override
  String get keypassUrl => 'https://otpuat.ssi.com.vn/keypass.wsmobile/';
}
