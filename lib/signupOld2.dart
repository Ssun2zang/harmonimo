import 'package:flutter/material.dart';
import 'package:harmonimo/MyController.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/signup_api.dart';
import 'package:harmonimo/mainpage.dart';
import 'package:harmonimo/diseaseSelect2.dart';

class SignUpOld2 extends StatefulWidget {
  const SignUpOld2({super.key});

  @override
  State<SignUpOld2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUpOld2> {
  var picker = ImagePicker();
  File? image;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final myController = Get.find<MyController>();
  SignUpApi signup = SignUpApi();

  String id = Get.arguments['id'];
  String pw = Get.arguments['pw'];

  bool isFemale = true;
  int gender = 0;
  int age = 0;

  bool rs = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("개인정보 입력",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 17,),
              Container(
                child: Text('자랑하고 싶은 사진',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              Container(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  width: 300,
                  height: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(
                        0x342baa00)),),
                    child: image==null
                        ? Icon(Icons.image)
                        : Image.network(image!.path,fit: BoxFit.fill),
                    onPressed: () async {
                      _pickImage();
                    },
                  )
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                width: 500,
                height: 48,
                child: TextField(
                    controller: _username,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '성함',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onTap: () => _username.clear(),
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
                    controller: _nickname,
                    onChanged: (value) {},
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: '별명',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        onTap: () => _nickname.clear(),
                      ),

                    )
                ),
              ),
              SizedBox(height: 17,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Text('성별',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),),
                  Container(width: 5,),
                  ToggleButtons(children: [
                    Icon(Icons.male),
                    Icon(Icons.female),
                  ],
                      isSelected:[!isFemale, isFemale],
                      onPressed: (index){
                        setState(() {
                          if(index == 0 ){
                            isFemale = false;
                          }
                          else{
                            isFemale = true;
                          }
                        });
                      }),

                  Container(
                    padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                    width: 200,
                    height: 48,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                        controller: _age,
                        onChanged: (value) {},
                        decoration: InputDecoration(border: OutlineInputBorder(),labelText: '연세',labelStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                            onTap: () => _age.clear(),
                          ),

                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17,),
              ElevatedButton(onPressed:(){
                Get.to(DiseaseSelectionPage());

              }, child: Container(
                width: 320,
                height: 48,
                child: Center(child: Text("본인 질환 등록",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20))),
              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
              SizedBox(height: 17,),
              ElevatedButton(onPressed: () async {
                try{
                  if(isFemale == true){
                    gender = 0;
                  }
                  else{
                    gender = 1;
                  }
                  age = int.parse(_age.text);
                  if(_username.text!=null&&_nickname.text!=null&&age!=0){
                    rs = await signup.Register(_username.text, _nickname.text, gender, age, id, pw, myController.selectedDiseaseIndexes);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("필수 정보를 모두 입력해 주세요")));
                  }
                }catch(e){
                  print('Error:$e');
                }
                if(rs == true){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("성고옹")));
                  Get.to(MainPage());
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("회원가입 실패")));
                }

              }, child: Container(
                width: 320,
                height: 48,
                child: Center(child: Text("가입하기",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20))),
              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(
                  0xDAA9CC60))))
            ],
          ),
        ),
      ),
    );;;
  }
}
