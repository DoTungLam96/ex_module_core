import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../constants/contants.dart';
import '../shared_preferences_manager.dart';

class DeviceIDService {
  Future<String> getDeviceID() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isIOS) {
        final iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor ?? '';
      } else if (Platform.isAndroid) {
        final androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id;
      } else {
        return getGenerateUUID();
      }
    } catch (e) {
      return getGenerateUUID();
    }
  }

  Future<Map<String, dynamic>> getOtherIdentifier() async {
    Map<String, dynamic> otherIdentifier = {};
    if (Platform.isIOS) {
      final deviceId = await getDeviceID();

      otherIdentifier = {"identifierForVendor": deviceId};
    } else if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      // from android 8.0. can't get android serial number
      final serialNumber = androidInfo.model;

      final androidId = await getDeviceID();

      otherIdentifier = {"AndroidID": androidId, "Serial": serialNumber};
    }
    return {"otherIdentifier": otherIdentifier};
  }

  /// Get generate UUID with uuid v4
  String getGenerateUUID() {
    final localUuid = GetIt.instance
        .get<SharedPreferencesManager>()
        .getString(KEY_GENERATE_UUID);

    if (localUuid != null && localUuid != "") {
      return localUuid;
    }

    const uuid = Uuid();
    final deviceId = uuid.v4();

    GetIt.instance
        .get<SharedPreferencesManager>()
        .putString(KEY_GENERATE_UUID, deviceId);

    return deviceId;
  }
}
