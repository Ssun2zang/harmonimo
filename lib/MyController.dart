import 'package:get/get.dart';

class MyController extends GetxController {
  RxList<int> selectedDiseaseIndexes = <int>[].obs;

  List<String> allDiseases = [
    '치매',
    '파킨슨 병',
    '결장, 직장암',
    '간암',
    '요추, 추간판 장애',
    '당뇨병',
    '무릎관절증',
    '고혈압성 질환',
    '대뇌혈관 질환',
    '기관지, 폐암',
    '위염',
    '치아 및 지지구조 질환',
    '급성 기관지염',
    '기타'
    // 여기에 질병들을 추가해주세요.
  ];

  void toggleDisease(int index) {
    if (selectedDiseaseIndexes.contains(index)) {
      selectedDiseaseIndexes.remove(index);
    } else {
      selectedDiseaseIndexes.add(index);
    }
  }


}
