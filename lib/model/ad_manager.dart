import 'dart:io';

import 'package:coduck/parameter/app_secret.dart';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_ADMOB_APP_ID>";
    } else if (Platform.isIOS) {
      return AppSecret.adAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
    } else if (Platform.isIOS) {
      return AppSecret.adUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
