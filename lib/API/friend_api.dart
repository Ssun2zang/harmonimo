import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FriendShowApi extends StatefulWidget {

  final int emoji;
  final int hat;
  final int face;
  final int pet;
  final String name;
  final String stat;

  const FriendShowApi({
    Key? key,
    required this.emoji,
    required this.hat,
    required this.face,
    required this.pet,
    required this.name,
    required this.stat
  }) : super(key: key);

  @override
  State<FriendShowApi> createState() => _FriendShowApiState();
}

class _FriendShowApiState extends State<FriendShowApi> {

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(Icons.person,color: Colors.black),
              Text(widget.name,style: TextStyle(color: Colors.black,fontSize: 25),)
            ],
          ),
          Container(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/image/mainMarimo.PNG'),
                _buildEmojiImage(widget.emoji),
                _buildHatImage(widget.hat),
                _buildFaceImage(widget.face),
                _buildPetImage(widget.pet),
              ],
            ),
          ),
          Container(
            child: Text("${widget.stat} 관리함",style: TextStyle(color: Colors.black,fontSize: 25)),
          )
        ],
      ),
    );
  }

  Widget _buildEmojiImage(int emoji) {
    switch (emoji) {
      case 1:
        return Image.asset('assets/image/faceHappy.PNG');
      case 2:
        return Image.asset('assets/image/faceSad.PNG');
      case 3:
        return Image.asset('assets/image/faceBored.PNG');
      case 4:
        return Image.asset('assets/image/faceAngry.PNG');
      case 5:
        return Image.asset('assets/image/faceWow.PNG');
      case 6:
        return Image.asset('assets/image/faceExcite.PNG');
    // 추가적인 emoji case들을 필요에 따라 계속 추가
      default:
        return Container(); // 기본값 처리
    }
  }

  Widget _buildHatImage(int hat) {
    switch (hat) {
      case 1:
        return Image.asset('assets/image/decoGat.PNG');
      case 2:
        return Image.asset('assets/image/decoWitch.PNG');
      case 3:
        return Image.asset('assets/image/decoParty.PNG');

    // 추가적인 emoji case들을 필요에 따라 계속 추가
      default:
        return Container(); // 기본값 처리
    }
  }

  Widget _buildFaceImage(int hat) {
    switch (hat) {
      case 1:
        return Image.asset('assets/image/decoRed.PNG');
      case 2:
        return Image.asset('assets/image/decoYellow.PNG');
      case 3:
        return Image.asset('assets/image/decoPink.PNG');
    // 추가적인 emoji case들을 필요에 따라 계속 추가
      default:
        return Container(); // 기본값 처리
    }
  }

  Widget _buildPetImage(int hat) {
    switch (hat) {
      case 1:
        return Image.asset('assets/image/petTurtle.PNG');
      case 2:
        return Image.asset('assets/image/petBoat.PNG');
      case 3:
        return Image.asset('assets/image/petShrimp.PNG');
    // 추가적인 emoji case들을 필요에 따라 계속 추가
      default:
        return Container(); // 기본값 처리
    }
  }
}
