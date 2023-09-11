import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class VoiceApi{
  Dio dio = Dio();
  Future<int> uploadVoiceFile(File audioFile) async {

    if (audioFile == null) {
      // 음성 파일이 선택되지 않았을 경우 에러 처리
      return 0;
    }

    String uploadUrl = 'http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/uploadNewRec'; // 서버의 업로드 엔드포인트 URL

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          audioFile!.path,
          filename: 'plz.mp3', // 업로드할 파일 이름
        ),
      });

      Response response = await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            // 필요한 헤더를 추가하세요 (예: 인증 토큰 등)
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.statusCode as int;
      } else {
        // 전송 실패
        print('Failed to send image and data. Status code: ${response.statusCode}');
        return response.statusCode as int;
      }



      // 업로드가 성공하면 서버 응답 처리
    } catch (e) {
      // 업로드 실패 시 에러 처리
      print('Error uploading voice file: $e');
      return 3;
    }

  }

  Future<int> uploadAudio(String _audioPath) async {
    if (_audioPath.isNotEmpty) {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_audioPath),
      });

      try {
        Response response = await dio.post('http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/uploadNewRec', data: formData);
        print('Upload success! Response: ${response.data}');
        if (response.statusCode == 200) {
          return 1;
        } else {
          // 전송 실패
          print('Failed to send image and data. Status code: ${response.statusCode}');
          return 2;
        }

      } catch (e) {
        return 4;
        print('Upload error: $e');
      }
    } else {
      return 3;
      print('No audio to upload.');
    }
  }
}