import 'dart:io';

class AdHelper {

  static String get bannerAdUnitIdOfHomeScreen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2180535035689124/1967287829';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitIdOfTabelScreen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2180535035689124/6380906053';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }


  static String get appOpenAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2180535035689124/1324305904';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}