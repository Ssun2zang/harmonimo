import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  Future<int> login(String id, String pw) async {
    // 여기에 요청을 보낼 서버의 URL을 입력하세요.
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';

    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/login?accountId=$id&password=$pw');

    final response = await http.get(url);

    print(response.statusCode);
    // 응답 상태 코드가 200 (OK) 인지 확인합니다.
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      int userId = jsonData["userId"];
      print(jsonDecode(response.body));
      return userId as int;
    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');
      return 0;
    }
  }
}
