import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:harmonimo/MyController.dart';

class MarimoDecoApi{
  final myController = Get.find<MyController>();

  Future<void> getInfo() async {
    int userId = myController.Id.value;
    // 여기에 요청을 보낼 서버의 URL을 입력하세요.
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';

    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/marimo/$userId');

    final response = await http.get(url);

    print(response.statusCode);
    // 응답 상태 코드가 200 (OK) 인지 확인합니다.
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      myController.emoji.value = jsonData["emotion"];
      myController.hat.value = jsonData["deco1"];
      myController.face.value = jsonData["deco2"];
      myController.pet.value = jsonData["deco3"];
      myController.MarimoId.value = jsonData["marimoId"];
      myController.Id.value = userId;
      print(jsonDecode(response.body));

    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');

    }
  }

  Future<void> putInfo() async{
    int userId = myController.Id.value;

    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';
    final apiUrl = Uri.parse('$baseUrl/marimo/$userId');

    final response = await http.put(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',  // 적절한 헤더 설정
      },
      body: jsonEncode(<String, dynamic>{
        'deco1': myController.hat.value,
        'deco2': myController.face.value,
        'deco3': myController.pet.value,
        'emotion': myController.emoji.value
      }),  // PUT 요청의 바디 데이터 설정
    );

    if (response.statusCode == 200) {
      print('yay');

    } else {

    }
  }
}