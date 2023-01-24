import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';

class CubeRootLogicScreen extends StatefulWidget {
  const CubeRootLogicScreen({super.key, required this.value});
  final int value;

  @override
  State<StatefulWidget> createState() { return new _CubeRootLogicScreenState();}

}

class _CubeRootLogicScreenState extends State<CubeRootLogicScreen> {

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
                        '\u221B${index+1} = ${num.parse(pow((index+1),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "2" ?
                        '\u221B${index+101} = ${num.parse(pow((index+101),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "3" ?
                        '\u221B${index+201} = ${num.parse(pow((index+201),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "4" ?
                        '\u221B${index+301} = ${num.parse(pow((index+301),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "5" ?
                        '\u221B${index+401} = ${num.parse(pow((index+401),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "6" ?
                        '\u221B${index+501} = ${num.parse(pow((index+501),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "7" ?
                        '\u221B${index+601} = ${num.parse(pow((index+601),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "8" ?
                        '\u221B${index+701} = ${num.parse(pow((index+701),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "9" ?
                        '\u221B${index+801} = ${num.parse(pow((index+801),1/3).toStringAsFixed(3))}' :
                        widget.value.toString() == "10" ?
                        '\u221B${index+901} = ${num.parse(pow((index+901),1/3).toStringAsFixed(3))}' :"",
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

