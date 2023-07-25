import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/loginpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 84,
            ),
            Container(

              child: Text("하모니모",style: TextStyle(fontSize: 50,color: Colors.black, fontWeight: FontWeight.w800,shadows: [Shadow(blurRadius: 4,
                  color: Color(0x3F000000),offset: Offset(0.0,4.0))]),),
            ),
            Spacer(),
            Container(
              height: 227,
              width: 241,
              child: Image.asset('assets/image/Main_image.png'),
            ),
            Spacer(),
            ElevatedButton(onPressed: () {
              Get.to(LoginPage());
            }, child: Container(
              width: 320,
              height: 48,
              child: Center(child: Text("로그인",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 12))),
            ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
            Spacer()

          ],
        ),
      ),
    );
  }
}

