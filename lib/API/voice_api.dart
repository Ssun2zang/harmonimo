import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:math';

class Message {
  String url;
  int id;
  Message(this.url, this.id);
}

class VoiceApi{
  final random = Random();
  Dio dio = Dio();
  Future<void> uploadUrlElder(String url,int Id) async{
    int temp = 1;
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/records';
    final Map<String,String> headers = {'Content-Type':'application/json'};
    //List<int> imageBytes = await imageFile.readAsBytes();
    //final String base64Image = base64Encode(imageBytes);
    final Map<String, dynamic> requestBody = {
      'senderId':Id,
      'receiverId':temp,
      'url':url
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
    } else {
      // 전송 실패
      print('Failed to send image and data. Status code: ${response.statusCode}');
    }
  }
  Future<void> uploadUrlUser(String url,int Id) async{
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/records';
    final Map<String,String> headers = {'Content-Type':'application/json'};
    //List<int> imageBytes = await imageFile.readAsBytes();
    //final String base64Image = base64Encode(imageBytes);
    final Map<String, dynamic> requestBody = {
      'senderId':1,
      'receiverId':Id,
      'url':url
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
    } else {
      // 전송 실패
      print('Failed to send image and data. Status code: ${response.statusCode}');
    }
  }
  Future<void> uploadUrlOther(String url,int senderId,receiveId) async{
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/records';
    final Map<String,String> headers = {'Content-Type':'application/json'};
    //List<int> imageBytes = await imageFile.readAsBytes();
    //final String base64Image = base64Encode(imageBytes);
    final Map<String, dynamic> requestBody = {
      'senderId':senderId,
      'receiverId':receiveId,
      'url':url
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
    } else {
      // 전송 실패
      print('Failed to send image and data. Status code: ${response.statusCode}');
    }
  }
  Future<String> uploadVoiceFile(File audioFile,int num) async {
    String name = '${random.nextInt(200)}_$num.m4a';
    if (audioFile == null) {
      // 음성 파일이 선택되지 않았을 경우 에러 처리
      return 'noFileExist';
    }
    String uploadUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/uploadNewRec'; // 서버의 업로드 엔드포인트 URL

    String fileExtension = extension(audioFile.path);
    print('File extension: $fileExtension');
    final List<int> fileBytesList = await audioFile.readAsBytes();
    final MultipartFile multipartFile = MultipartFile.fromBytes(
      fileBytesList,
      filename: name,
    );

    FormData formData = FormData.fromMap({
      'file': multipartFile,
    });

    try {
      Response response = await dio.post(
        uploadUrl, // 파일을 업로드할 API 엔드포인트 URL
        data: formData,
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        final Map<String, dynamic> jsonResponse = response.data;
        String result = jsonResponse['uploadRec'];
        return result;
      } else {
        // 전송 실패
        print('Failed to send image and data. Status code: ${response.statusCode}');
        return 'Failed to send image and data. Status code: ${response.statusCode}';
      }
      // 업로드가 성공하면 서버 응답 처리
    } catch (e) {
      // 업로드 실패 시 에러 처리
      print('Error uploading voice file: $e');
      return 'Error uploading voice file: $e';
    }

  }
  Future<List<Message>> getMessages(int id) async{
    List<Message> myList =[];
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';
    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/records/receiver/$id');

    final response = await http.get(url);
    // 응답 상태 코드가 200 (OK) 인지 확인합니다.
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      // JSON 배열에 대한 반복문을 사용하여 각 JSON 객체에 접근합니다.
      for (var jsonItem in jsonResponse) {
        // 여기에서 각 JSON 객체의 특정 필드에 접근할 수 있습니다.
        final String url = jsonItem['url'];
        final int id = jsonItem['receiverId'];
        Message temp = Message(url, id);
        myList.add(temp);
      }
      return myList;
    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');
    }

    return myList;
  }
  Future<String> getName(int id) async {
    if(id == 100){
      return "보호자";
    }
    final String baseUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080';

    // HTTP GET 요청을 보냅니다.
    final url = Uri.parse('$baseUrl/marimo/$id');

    final response = await http.get(url,
      headers: <String, String>{
        'Accept-Charset': 'UTF-8',
      },);

    // 응답 상태 코드가 200 (OK) 인지 확인합니다.
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      String marimoName = jsonData["name"];
      print(marimoName);
      return marimoName;
    } else {
      // 요청이 실패하면 에러 메시지를 반환합니다.
      print('Failed');
      return '';
    }
  }



}