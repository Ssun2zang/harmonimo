import 'package:get/get.dart';
import 'package:harmonimo/API/marimoDeco_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyController extends GetxController {

  RxInt emoji = 1.obs;
  RxInt hat = 0.obs;
  RxInt face = 0.obs;
  RxInt pet = 0.obs;
  RxInt Id = 0.obs;
  RxInt MarimoId = 0.obs;
  RxInt st1 = 0.obs;
  RxInt st2 = 0.obs;
  RxInt st3 = 0.obs;
  RxString stText1 = RxString('데이터가 없어요');
  RxString stText2 = RxString('데이터가 없어요');
  RxString stText3 = RxString('데이터가 없어요');

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

  void onInit(){
    super.onInit();
    marimoRefresh();

    ever(emoji, (int newEmojiValue) {
      print('emoji value changed to: $newEmojiValue');
      MarimoDecoApi().putInfo();
      // 원하는 동작 수행
    });

    // hat 값이 변할 때마다 실행되는 리스너
    ever(hat, (int newHatValue) {
      print('hat value changed to: $newHatValue');
      MarimoDecoApi().putInfo();
      // 원하는 동작 수행
    });

    // face 값이 변할 때마다 실행되는 리스너
    ever(face, (int newFaceValue) {
      print('face value changed to: $newFaceValue');
      MarimoDecoApi().putInfo();
      // 원하는 동작 수행
    });

    // pet 값이 변할 때마다 실행되는 리스너
    ever(pet, (int newPetValue) {
      print('pet value changed to: $newPetValue');
      MarimoDecoApi().putInfo();
      // 원하는 동작 수행
    });
  }

  Future<void> marimoRefresh() async {
    while (true) {
      // API 호출 및 데이터 업데이트
      fetchDataFromServer();
      await Future.delayed(Duration(seconds: 10));
    }
  }

  Future<void> fetchDataFromServer() async {
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';

    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/marimoDatas/recent/$Id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      st1.value = jsonData["stat1"];
      st2.value = jsonData["stat2"];
      st3.value = jsonData["stat3"];
      if(st1.value<200){
        stText1.value = '너무 어두워요!';

      }
      else if(st1.value<850){
        stText1.value = '좋아요!';

      }
      else{
        stText1.value = '너무 밝아요!';
      }
      if(st2.value<14){
        stText2.value = '추워요!';
      }
      else if(st2.value<25){
        stText2.value = '좋아요!';
      }
      else{
        stText2.value = '너무 더워요!';
      }
      if(st3.value<200){
        stText3.value = '좋아요!';
      }
      else if(st3.value<350){
        stText3.value = '물이 조금 탁해요.';
      }
      else{
        stText3.value = '물이 너무 더러워요!';
      }
      print(jsonDecode(response.body));
    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');

    }
  }
  void toggleDisease(int index) {
    if (selectedDiseaseIndexes.contains(index)) {
      selectedDiseaseIndexes.remove(index);
    } else {
      selectedDiseaseIndexes.add(index);
    }
  }


}
