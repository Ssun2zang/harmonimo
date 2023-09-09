import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/MyController.dart';

class MarimoShowApi extends StatefulWidget {


  const MarimoShowApi({super.key});

  @override
  State<MarimoShowApi> createState() => _MarimoShowApiState();
}

class _MarimoShowApiState extends State<MarimoShowApi> {
  final MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/image/mainMarimo.PNG'),
          _buildEmojiImage(myController.emoji.value),
          _buildHatImage(myController.hat.value),
          _buildFaceImage(myController.face.value),
          _buildPetImage(myController.pet.value),
        ],
      ),
    ));
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
