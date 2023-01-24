import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:square_cube_root_and_factorial/Screens/FactorialScreen.dart';
import '../AdsHelper/adshelper.dart';
import 'CubeRootScreen.dart';
import 'CubeScreen.dart';
import 'SquareRootScreen.dart';
import 'SquareScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BannerAd _bannerAd;
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  bool _isBannerAdReady = false;

  List<String> _list = ["Square (x\u00B2) ","Cube (x\u00B3)","Square Root (\u221Ax)","Cube Root (\u221Bx)","Factorial (x!)"];


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

          Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1,
                childAspectRatio: 3,
                children: _list.map((value) {
                  return GestureDetector(
                    onTap:() {
                      if((_list.indexOf(value)+1) == 1)
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SquareScreen()));
                        }
                      if((_list.indexOf(value)+1) == 2)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CubeScreen()));
                      }
                      if((_list.indexOf(value)+1) == 3)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SquareRootScreen()));
                      }
                      if((_list.indexOf(value)+1) == 4)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CubeRootScreen()));
                      }
                      if((_list.indexOf(value)+1) == 5)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FactorialScreen()));
                      }

                      },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child:  Text(
                            "${value}",
                            style: GoogleFonts.frederickaTheGreat(textStyle: TextStyle(fontSize: 44,color: Colors.white,fontWeight: FontWeight.w300)),textAlign: TextAlign.center
                            ,
                          )
                        ),

                      ],
                    ),
                  );
                }).toList(),
            ),
          )],
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

