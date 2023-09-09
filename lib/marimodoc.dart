import 'package:flutter/material.dart';
import 'package:harmonimo/API/marimoStat_api.dart';

class MarimoDoc extends StatefulWidget {
  const MarimoDoc({super.key});

  @override
  State<MarimoDoc> createState() => _MarimoDocState();
}

class _MarimoDocState extends State<MarimoDoc> {
  TextStyle customTextStyle = TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("마리모 진단",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Container(child: Text('키우기 팁!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),),
                  Container(child: RichText(text: TextSpan(
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                    children: <TextSpan> [
                      TextSpan(text: '낮에는 광합성을 위해 꼭 해가 잘드는 곳\n에 배치해 주세요! 그치만 절대'),
                      TextSpan(text: ' 햇빛을 직접\n받으면 안된답니다!',style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: '직사광선은 마리모에\n게 독이에요!')
                    ]
                  ),),),
                  Container(child: RichText(text: TextSpan(
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                      children: <TextSpan> [
                        TextSpan(text: '물 온도는'),
                        TextSpan(text: '20도',style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: ' 정도로 맞춰 주는 것이 좋\n아요. 날씨가 더우면 마리모 수조에 얼음을\n넣거나 냉장고에 넣어 놓는 등 온도를 시원\n하게 조절해주는 것도 좋아요!')
                      ]
                  )),),
                  Image.asset('assets/image/yellowMarimo.PNG'),
                  Container(child: RichText(text: TextSpan(
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                      children: <TextSpan> [
                        TextSpan(text: '위와 같이 색이 노랗게 변하고 있다면 마리\n모가 광합성을 하지 못하여 아픈것이니 반\n드시 관리해 주어야 해요!\n이럴땐 아주 미량의'),
                        TextSpan(text: '소금',style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: '을 넣어주면 마리\n모를 건강하게 만들 수 있답니다. 어항을 청결\n하게 유지해주는 것은 당연하고요 !')
                      ]
                  )),),
                  Image.asset('assets/image/goodMarimo.PNG'),
                  Text('위 사진은 건강한 마리모 모습이에요')
                ],
              ),
        ),
      ),);

  }
}
