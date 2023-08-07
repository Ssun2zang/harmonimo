import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/loginOld.dart';
import 'package:harmonimo/signupOld.dart';


class LoginPageOld extends StatefulWidget {
  const LoginPageOld({super.key});

  @override
  State<LoginPageOld> createState() => _LoginPageOldState();
}

class _LoginPageOldState extends State<LoginPageOld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("고유번호 확인법",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset('assets/image/explain_image.png'),
            ),
            SizedBox(height: 25),
            ElevatedButton(onPressed: (){
              Get.to(SignUpOld());
            }, child: Container(
              width: 320,
              height: 79,
              child: Center(child: Text("회원가입",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20))),
            ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
            SizedBox(height: 25),
            ElevatedButton(onPressed: (){
              Get.to(LoginOld());
            }, child: Container(
              width: 320,
              height: 79,
              child: Center(child: Text("로그인",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20))),
            ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),


          ],
        ),
      ),
    );
  }
}
