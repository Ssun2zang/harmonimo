import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpApi {
  Future<int> IsAvailable(String id) async {
    // 여기에 요청을 보낼 서버의 URL을 입력하세요.
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';

    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/marimos/find/$id');

    final response = await http.get(url);

    print(response.statusCode);
    // 응답 상태 코드가 200 (OK) 인지 확인합니다.
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      int marimoId = jsonData["marimoId"];
      print(jsonDecode(response.body));
      return marimoId as int;
    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');
      return 0;
    }
  }

  Future<bool> Register(String name,String nickname,int gender,int age,String id,String pw,List<int> disease) async{

    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/register';
    final Map<String,String> headers = {'Content-Type':'application/json'};
    //List<int> imageBytes = await imageFile.readAsBytes();
    //final String base64Image = base64Encode(imageBytes);
    final Map<String, dynamic> requestBody = {
      'name': name,
      'nickname': nickname,
      'gender': gender,
      'old': age,
      'profileImg': 'none',
      'accountId': id,
      'password': pw,
      'diseases':disease
    };
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // 성공적으로 이미지와 데이터를 서버로 보냈습니다.
      bool result = response.body == 'true'; // response.body가 'true'인 경우 true, 그 외에는 false로 처리
      print('Response: $result');

      return result;
    } else {
      // 전송 실패
      print('Failed to send image and data. Status code: ${response.statusCode}');
      return false;
    }

  }


}
