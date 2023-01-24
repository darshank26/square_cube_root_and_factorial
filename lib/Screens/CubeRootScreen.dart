import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';
import 'CubeLogicScreen.dart';
import 'CubeRootLogicScreen.dart';

class CubeRootScreen extends StatefulWidget {
  const CubeRootScreen({Key? key}) : super(key: key);

  @override
  State<CubeRootScreen> createState() => _CubeRootScreenState();

}

class _CubeRootScreenState extends State<CubeRootScreen> {

  final table = List<String>.generate(10, (i) => 'Product $i');
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  List<String> _list = ["Cube Root from 0 to 100","Cube Root from 101 to 200","Cube Root from 201 to 300","Cube Root from 301 to 400","Cube Root from 401 to 500","Cube Root from 501 to 600","Cube Root from 601 to 700","Cube Root from 701 to 800","Cube Root from 801 to 900","Cube Root from 901 to 1000"];

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
                return GestureDetector(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CubeRootLogicScreen(value:(index+1))));
                    print("-------"+{index+1}.toString());
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20,left: 4,right:4),
                     child:
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          _list[index].toString(),
                          style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                          ,
                        ),
                      ) ),
                );


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

