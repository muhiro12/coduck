import 'dart:io';

import 'package:coduck/parameter/app_secret.dart';
import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  static BannerAd _bannerAd;

  static Future init() {
    return FirebaseAdMob.instance.initialize(
      appId: _AdMobManager._appId,
    );
  }

  static void showBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _AdMobManager._bannerAdUnitId,
      size: AdSize.fullBanner,
    );
    _bannerAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
  }

  static void hideBannerAd() {
    _bannerAd?.dispose();
  }
}

class _AdMobManager {
  static String get _appId {
    if (Platform.isAndroid) {
      return AppSecret.adAndroidAppId;
    } else if (Platform.isIOS) {
      return AppSecret.adIOSAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get _bannerAdUnitId {
    if (Platform.isAndroid) {
      return AppSecret.adAndroidUnitId;
    } else if (Platform.isIOS) {
      return AppSecret.adIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
