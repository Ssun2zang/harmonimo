import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("로그인",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18)),backgroundColor: Colors.white,centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black
      ),),
    );
  }
}
