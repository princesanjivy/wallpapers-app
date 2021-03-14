import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class ShowInterstitialAd extends StatefulWidget {
  @override
  _ShowInterstitialAdState createState() => _ShowInterstitialAdState();
}

class _ShowInterstitialAdState extends State<ShowInterstitialAd> {
  AdmobInterstitial _interstitial;

  @override
  void initState() {
    super.initState();

    _interstitial = AdmobInterstitial(
        adUnitId: "ca-app-pub-3940256099942544/10331"
            "73712");
    _interstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ShowAd {
  AdmobInterstitial _interstitial;

  ShowAd() {
    _interstitial = AdmobInterstitial(
        adUnitId: "ca-app-pub-3940256099942544/10331"
            "73712");
    _interstitial.load();
  }

  Future<String> show() async {
    if (await _interstitial.isLoaded) {
      _interstitial.show();
      _interstitial.dispose();
      return "Ad is showing";
    } else {
      _interstitial.dispose();
      return "Ad is not loaded!";
    }
  }
}
