import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/signup_api.dart';
import 'package:harmonimo/signup2.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpApi signup = SignUpApi();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  String id='';
  String pw='';
  int marimoId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
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
              SizedBox(height: 32,),
              Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                width: 500,
                child: TextField(
                    controller: _textEditingController2,
                    obscureText: _obscureText1,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '비밀번호',labelStyle: TextStyle(color: Colors.grey),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _obscureText1 ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      ),

                    )
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                width: 500,
                child: TextField(
                    controller: _textEditingController3,
                    obscureText: _obscureText2,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '비밀번호 재확인',labelStyle: TextStyle(color: Colors.grey),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _obscureText2 ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),

                    )
                ),
              ),
              SizedBox(height: 31,),
              ElevatedButton(onPressed: () async {
                try{
                  marimoId = await signup.IsAvailable(_textEditingController1.text);
                }catch(e){
                  print('Error:$e');
                }
                if(marimoId!=0){//사용자 존재
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("이미 존재하는 고유번호입니다.")));
                }
                else{
                  if(_textEditingController2.text==_textEditingController3.text){
                    id = _textEditingController1.text;
                    pw = _textEditingController2.text;
                    Get.to(SignUp2(),arguments: {'id':'$id','pw':'$pw'});
                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("고고.")));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("입력하신 비밀번호가 다릅니다.")));
                  }

                }

              }, child: Container(
                width: 320,
                height: 48,
                child: Center(child: Text("가입하기",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20))),
              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),

            ],
          ),
        ),
      ),
    );
  }
}
