import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/MyController.dart';

class MarimoStatApi extends StatefulWidget {
  const MarimoStatApi({super.key});

  @override
  State<MarimoStatApi> createState() => _MarimoStatApiState();
}

class _MarimoStatApiState extends State<MarimoStatApi> {

  final myController = Get.find<MyController>();
  TextStyle myStyle = TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("빛",style: myStyle,),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                ),
                Container(
                  child: Text(myController.stText1.value,style: myStyle),margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("온도",style: myStyle),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                ),
                Container(
                  child: Text(myController.stText2.value,style: myStyle),margin: EdgeInsets.fromLTRB(00, 0, 20, 0),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("수질",style: myStyle),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                ),
                Container(
                  child: Text(myController.stText3.value,style: myStyle),margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                )
              ],
            ),
          ),
        ],
      ),

    ));
  }
}
