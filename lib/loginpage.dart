import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/login_api.dart';
import 'package:harmonimo/signup.dart';
import 'package:harmonimo/mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginApi loginApi = LoginApi();
  int userId = 0;
  bool _obscureText = true;

  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:AppBar(title: Text("일반 로그인",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18)),backgroundColor: Colors.white,centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black
      ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: 500,
                child: TextField(
                  controller: _textEditingController1,
                  onChanged: (value) {},
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: '고유번호',labelStyle: TextStyle(color: Colors.grey),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onTap: () => _textEditingController1.clear(),
                      ),

                )
                ),
              ),
              SizedBox(height: 50,),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: 500,
                child: TextField(
                  controller: _textEditingController2,
                    obscureText: _obscureText,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '비밀번호',labelStyle: TextStyle(color: Colors.grey),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),

                    )
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: TextButton(onPressed: () {
                  Get.to(SignUp());
                }, child: Text("회원가입 >",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))

              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () async {
                try{
                  userId = await loginApi.login(_textEditingController1.text, _textEditingController2.text);


                }catch(e){
                  print('Error:$e');
                }
                if(userId!=0){
                  Get.to(MainPage());
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("로그인 실패")));
                }
              }, child: Container(
                width: 320,
                height: 48,
                child: Center(child: Text("로그인",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20))),
              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                TextButton(onPressed: (){

                }, child: Text("고유번호 확인하는 법",style: TextStyle(color: Colors.grey),)),
                TextButton(onPressed: (){

                }, child: Text("비밀번호 찾기",style: TextStyle(color: Colors.grey)))
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
