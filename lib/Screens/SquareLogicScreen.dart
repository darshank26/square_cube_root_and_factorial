import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';

class SquareLogicScreen extends StatefulWidget {
  const SquareLogicScreen({super.key, required this.value});
  final int value;

  @override
  State<StatefulWidget> createState() { return new _SquareLogicScreenState();}

}

class _SquareLogicScreenState extends State<SquareLogicScreen> {

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
              itemCount: 100,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(14),
                    child:
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                          widget.value.toString() == "1" ?
                          '${index+1}\u00B2 = ${(index+1)*(index+1)}' :
                          widget.value.toString() == "2" ?
                          '${index+101}\u00B2 = ${(index+101)*(index+101)}' :
                          widget.value.toString() == "3" ?
                          '${index+201}\u00B2 = ${(index+201)*(index+201)}' :
                          widget.value.toString() == "4" ?
                          '${index+301}\u00B2 = ${(index+301)*(index+301)}' :
                          widget.value.toString() == "5" ?
                          '${index+401}\u00B2 = ${(index+401)*(index+401)}' :
                          widget.value.toString() == "6" ?
                          '${index+501}\u00B2 = ${(index+501)*(index+501)}' :
                          widget.value.toString() == "7" ?
                          '${index+601}\u00B2 = ${(index+601)*(index+601)}' :
                          widget.value.toString() == "8" ?
                          '${index+701}\u00B2 = ${(index+701)*(index+701)}' :
                          widget.value.toString() == "9" ?
                          '${index+801}\u00B2 = ${(index+801)*(index+801)}' :
                          widget.value.toString() == "10" ?
                          '${index+901}\u00B2 = ${(index+901)*(index+901)}' : "",
                          style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
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
}

