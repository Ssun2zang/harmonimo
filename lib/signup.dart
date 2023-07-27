import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _textEditingController1 = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
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
              ElevatedButton(onPressed: (){

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
