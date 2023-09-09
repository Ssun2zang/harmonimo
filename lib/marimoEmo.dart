import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/MyController.dart';

class MyButtonInfo {
  final String imagePath;
  final String buttonText;


  MyButtonInfo(this.imagePath, this.buttonText);
}

final List<MyButtonInfo> buttonInfos = [
  MyButtonInfo('assets/image/emojiHappy.PNG', '기뻐요!'),
  MyButtonInfo('assets/image/emojiSad.PNG', '슬퍼요!'),
  MyButtonInfo('assets/image/emojiBored.PNG', '심심해요!'),
  MyButtonInfo('assets/image/emojiAngry.PNG', '화나요!'),
  MyButtonInfo('assets/image/emojiWow.PNG', '놀라워요!'),
  MyButtonInfo('assets/image/emojiExcite.PNG', '신나요!'),
];

class MarimoEmo extends StatefulWidget {
  const MarimoEmo({super.key});

  @override
  State<MarimoEmo> createState() => _MarimoEmoState();
}

class _MarimoEmoState extends State<MarimoEmo> {
  MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("마리모 꾸미기",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
          Image.asset('assets/image/emoji.PNG')
        ],
      ),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MarimoShowApi(),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffe3eecf),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 열 개수
                  childAspectRatio: 2, // 버튼 가로세로 비율 (1:1로 유지)
                ), itemCount: buttonInfos.length,
                    itemBuilder: (BuildContext context,int index){
                      final MyButtonInfo buttonInfo = buttonInfos[index];
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(onPressed: (){
                          myController.emoji.value = index+1;
                        },
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green,width: 4),
                              borderRadius: BorderRadius.circular(18)
                          ),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                buttonInfo.imagePath,
                                width: 80, // 이미지 너비 조절
                                height: 80,
                                fit: BoxFit.contain, // 이미지를 버튼 크기에 맞게 조절
                              ),

                              Text(
                                buttonInfo.buttonText, // 버튼 텍스트
                                style: TextStyle(fontSize: 13, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )),
                      );
                    }),
              )
            ],
          ),
        ),
      )

    );
  }
}
