import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsHelper/adshelper.dart';
import 'FactorialLogicScreen.dart';

class FactorialScreen extends StatefulWidget {
  const FactorialScreen({Key? key}) : super(key: key);

  @override
  State<FactorialScreen> createState() => _FactorialScreenState();

}

class _FactorialScreenState extends State<FactorialScreen> {

  final table = List<String>.generate(10, (i) => 'Product $i');
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  List<String> _list = ["Factorial from 0 to 10","Factorial from 11 to 20","Factorial from 21 to 30","Factorial from 31 to 40","Factorial from 41 to 50","Factorial from 51 to 60","Factorial from 61 to 70","Factorial from 71 to 80","Factorial from 81 to 90","Factorial from 91 to 100"];

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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FactorialLogicScreen(value:(index+1))));
                    print("-------"+{index+1}.toString());
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20,left: 4,right:4),
                      child:
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          _list[index].toString(),
                          style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
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

