// ignore: import_of_legacy_library_into_null_safe

import 'package:shared_preferences/shared_preferences.dart';

import 'env/devEnv.dart';
import 'env/networkEnv.dart';
import 'env/proEnv.dart';
import 'env/uatEnv.dart';

enum Env { Dev, Uat, Pro }

extension ParseToString on Env {
  String shortName() {
    return toString().split('.').last;
  }
}

class Network {
  // Init environment
  Env _env = Env.Pro;

  NetworkEnv get domain {
    switch (_env) {
      case Env.Dev:
        return DevEnv();
      case Env.Uat:
        return UatEnv();
      case Env.Pro:
        return ProEnv();
    }
  }

  Env get env => _env;

  Network initEnv({required Env newEnv}) {
    _env = newEnv;
    return this;
  }

  static Network devNetwork() => Network().initEnv(newEnv: Env.Dev);
  static Network uatNetwork() => Network().initEnv(newEnv: Env.Uat);
  static Network prodNetwork() => Network().initEnv(newEnv: Env.Pro);
}
