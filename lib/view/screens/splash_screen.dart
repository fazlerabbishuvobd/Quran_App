import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage(),))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/image/quran.png',height: 300,fit: BoxFit.cover,),
            const Spacer(),
            const SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ),
            const SizedBox(height: 20),

            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Design and Developed by'),
                Text('Fazle Rabbi'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
