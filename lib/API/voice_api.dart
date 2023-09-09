import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class VoiceApi{

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