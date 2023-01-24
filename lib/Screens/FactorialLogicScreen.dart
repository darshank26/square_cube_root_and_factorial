import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';

class FactorialLogicScreen extends StatefulWidget {
  const FactorialLogicScreen({super.key, required this.value});
  final int value;

  @override
  State<StatefulWidget> createState() { return new _FactorialLogicScreenState();}

}

class _FactorialLogicScreenState extends State<FactorialLogicScreen> {

  final table = List<String>.generate(10, (i) => 'Product $i');
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitIdOfTabelScreen,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();

  }


  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),

          ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(14),
                    child:
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.value.toString() == "1" ?
                        '${index+1} ! = ${factorial((index+1))}' :
                        widget.value.toString() == "2" ?
                        '${index+11} ! = ${factorial((index+11))}' :
                        widget.value.toString() == "3" ?
                        '${index+21} ! = ${factorial((index+21))}' :
                        widget.value.toString() == "4" ?
                        '${index+31} ! = ${factorial((index+31))}' :
                        widget.value.toString() == "5" ?
                        '${index+41} ! = ${factorial((index+41))}' :
                        widget.value.toString() == "6" ?
                        '${index+51} ! = ${factorial((index+51))}' :
                        widget.value.toString() == "7" ?
                        '${index+61} ! = ${factorial((index+61))}' :
                        widget.value.toString() == "8" ?
                        '${index+71} ! = ${factorial((index+71))}' :
                        widget.value.toString() == "9" ?
                        '${index+81} ! = ${factorial((index+81))}' :
                        widget.value.toString() == "10" ?
                        '${index+91} ! = ${factorial((index+91))}' : "",
                        style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                        ,
                      ),
                    ) );


              }),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isBannerAdReady)
              Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: Center(child: AdWidget(ad: _bannerAd)),
              ),
          ],
        ),
      ),


    );
  }

  double factorial(double n) {
    return n == 1 ? 1 : n * factorial(n - 1);
  }
}

