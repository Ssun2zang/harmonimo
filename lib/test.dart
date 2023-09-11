import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AudioRecordingScreen extends StatefulWidget {
  @override
  _AudioRecordingScreenState createState() => _AudioRecordingScreenState();
}

class _AudioRecordingScreenState extends State<AudioRecordingScreen> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  String _recordedFilePath = '';
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder.openRecorder().then((value) {
      print("Audio session is open: $value");
    });
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      await _audioRecorder.startRecorder(
        toFile: "your_audio_filename.mp3",
        codec: Codec.mp3,
      );
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      String path = await _audioRecorder.stopRecorder().toString();
      setState(() {
        _recordedFilePath = path;
        _isRecording = false;
      });
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> _uploadAudioFile() async {
    if (_recordedFilePath != null) {
      File audioFile = File(_recordedFilePath);
      if (audioFile.existsSync()) {
        var request = http.MultipartRequest('POST', Uri.parse('http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/uploadNewRec'));
        request.files.add(await http.MultipartFile.fromPath('file', _recordedFilePath));

        try {
          final response = await request.send();
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SENT")));
            // 파일 업로드 성공
            print('File uploaded successfully');
          } else {
            // 파일 업로드 실패
            print('File upload failed with status code: ${response.statusCode}');
          }
        } catch (e) {
          print('Error uploading file: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오디오 녹음 및 업로드'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!_isRecording)
              ElevatedButton(
                onPressed: _startRecording,
                child: Text('녹음 시작'),
              ),
            if (_isRecording)
              ElevatedButton(
                onPressed: _stopRecording,
                child: Text('녹음 중지'),
              ),
            if (_recordedFilePath != null)
              ElevatedButton(
                onPressed: _uploadAudioFile,
                child: Text('파일 업로드'),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AudioRecordingScreen(),
  ));
}
