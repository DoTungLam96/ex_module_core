import 'networkEnv.dart';

class UatEnv implements NetworkEnv {
  @override
  String get baseUrl => 'https://iboard-uat.ssi.com.vn';

  @override
  String get apiUrl => 'https://iboard-api-uat.ssi.com.vn';

  @override
  String get priceStream => "wss://iboard-pushstream-uat.ssi.com.vn/realtime";

  @override
  String get txnStream => "wss://txnstream-uat-iboard.ssi.com.vn/realtime";

  @override
  String get queryUrl => "https://iboard-query-uat.ssi.com.vn";

  @override
  String get tAPIUrl => "https://iboard-tapi-uat.ssi.com.vn";

  @override
  String get keypassUrl => 'https://otpuat.ssi.com.vn/keypass.wsmobile/';
}
