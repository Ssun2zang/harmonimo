import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/MyController.dart';

class MyButtonInfo {
  final String imagePath;
  final String buttonText;
  final String info;
  final Offset imageOffset;
  final double scale;
  final int idx;

  MyButtonInfo(this.imagePath, this.buttonText,this.info,this.imageOffset,this.scale,this.idx);
}
final List<MyButtonInfo> buttonInfos = [
  MyButtonInfo('assets/image/decoGat.PNG', '갓','hat',Offset(-10.0,3.0),2.8,1),
  MyButtonInfo('assets/image/decoWitch.PNG', '마녀모자','hat',Offset(-8.0,4.0),3,2),
  MyButtonInfo('assets/image/decoParty.PNG', '파티모자','hat',Offset(-9.0,3.0),2.5,3),
  MyButtonInfo('assets/image/decoRed.PNG', '빨강 볼','face',Offset(-6.0,0.0),5,1),
  MyButtonInfo('assets/image/decoYellow.PNG', '노랑 볼','face',Offset(-6.0,0.0),5,2),
  MyButtonInfo('assets/image/decoPink.PNG', '분홍 볼','face',Offset(-6.0,0.0),5,3),
  MyButtonInfo('assets/image/petTurtle.PNG', '애완 거북이','pet',Offset(8.0,-3.0),5,1),
  MyButtonInfo('assets/image/petBoat.PNG', '장난감 배','pet',Offset(8.0,-3.0),5,2),
  MyButtonInfo('assets/image/petShrimp.PNG', '애완 새우','pet',Offset(8.0,-3.0),5,3),
  // 나머지 버튼 정보도 추가
];
class MarimoDeco extends StatefulWidget {
  const MarimoDeco({super.key});

  @override
  State<MarimoDeco> createState() => _MarimoDecoState();
}

class _MarimoDecoState extends State<MarimoDeco> {

  MyController myController = Get.find<MyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("마리모 꾸미기",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
          Image.asset('assets/image/star.PNG')
        ],
      ),backgroundColor: Colors.white, centerTitle: true,
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
                  crossAxisCount: 3, // 열 개수
                  childAspectRatio: 1, // 버튼 가로세로 비율 (1:1로 유지)
                ), itemCount: buttonInfos.length,
                    itemBuilder: (BuildContext context,int index){
                      final MyButtonInfo buttonInfo = buttonInfos[index];
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(onPressed: (){
                          if(buttonInfo.info=='hat'){
                            if(myController.hat.value==buttonInfo.idx){
                              myController.hat.value = 0;
                            }
                            else{
                              myController.hat.value = buttonInfo.idx;
                            }
                          }
                          else if(buttonInfo.info=='face'){
                            if(myController.face.value==buttonInfo.idx){
                              myController.face.value = 0;
                            }
                            else{
                              myController.face.value = buttonInfo.idx;
                            }
                          }
                          else if(buttonInfo.info=='pet'){
                            if(myController.pet.value==buttonInfo.idx){
                              myController.pet.value = 0;
                            }
                            else{
                              myController.pet.value = buttonInfo.idx;
                            }
                          }
                        }, style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green,width: 4),
                              borderRadius: BorderRadius.circular(18)
                          ),
                        ),
                        child:Container(
                          height: 150,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: buttonInfo.scale, // 이미지를 2배로 확대
                                child: Transform.translate(
                                  offset: buttonInfo.imageOffset ?? Offset(0, 0),
                                  child: Image.asset(buttonInfo.imagePath,
                                    fit: BoxFit.cover, // 이미지 비율 유지하며 확대
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                buttonInfo.buttonText, // 버튼 텍스트
                                style: TextStyle(fontSize: 13, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),),
                      );
                    }),
              )

            ]
          ),
        ),
      )
    );
  }
}
