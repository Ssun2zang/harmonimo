import 'package:flutter/material.dart';

class SignUpOld extends StatefulWidget {
  const SignUpOld({super.key});

  @override
  State<SignUpOld> createState() => _SignUpOldState();
}

class _SignUpOldState extends State<SignUpOld> {
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                width: 500,
                height: 48,
                child: TextField(
                    controller: _textEditingController1,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '고유번호 입력',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
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
              SizedBox(height: 17,),
              Container(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                width: 500,
                height: 48,
                child: TextField(
                    controller: _textEditingController2,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '비밀번호 입력',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onTap: () => _textEditingController2.clear(),
                      ),

                    )
                ),
              ),
              SizedBox(height: 17,),
              Container(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                width: 500,
                height: 48,
                child: TextField(
                    controller: _textEditingController3,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '비밀번호 다시 입력',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onTap: () => _textEditingController3.clear(),
                      ),

                    )
                ),
              ),
              SizedBox(height: 36,),
              ElevatedButton(onPressed: (){

              }, child: Container(
                width: 320,
                height: 79,
                child: Center(child: Text("가입하기",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25))),
              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
            ],
          ),
        ),
      ),
    );
  }
}
