import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/view/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage(),)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/image/quran.png',height: height*0.3,fit: BoxFit.cover,),
            const Spacer(),
            const SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ),
            SizedBox(height: height*0.03),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Design and Developed by',style: myFontStyle.copyWith(fontSize: 18),),
                Text('Fazle Rabbi',style: myFontStyle.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: height*0.02),
          ],
        ),
      ),
    );
  }
  final myFontStyle = GoogleFonts.averiaLibre(fontSize: 14);
}
