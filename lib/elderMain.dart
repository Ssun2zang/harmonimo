import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/API/marimoStat_api.dart';
import 'package:harmonimo/API/voice_api.dart';
import 'package:harmonimo/marimodoc.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ElderMain extends StatefulWidget {
  const ElderMain({super.key});

  @override
  State<ElderMain> createState() => _ElderMainState();
}

class _ElderMainState extends State<ElderMain> {
  TextStyle myStyle = TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold);
  final recorder = FlutterSoundRecorder();
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isRecorderReady = false;
  File audioFile = File('');
  VoiceApi voiceApi = VoiceApi();
  Dio dio = Dio();

  @override
  void initState(){
    super.initState();
    initRecorder();

  }

  @override
  void dispose(){
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw 'Permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(microseconds: 500));
  }

  Future record() async {
    if(!isRecorderReady){
      return;
    }
    await recorder.startRecorder(toFile: 'audio');
  }



  Future<String> uploadRecord(File File) async {
    final url = Uri.parse('http://ec2-3-39-175-221.ap-northeast-2.compute.amazonaws.com:8080/uploadNewRec');
    if (File == null) {
      return "";
    }

    // open the image file
    final bytes = await File.readAsBytes();

    // create the multipart request
    final request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile.fromBytes('file', bytes,
          filename: 'ex.mp3'));

    // send the request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    // check the response status code
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(responseBody);
      final Url = responseJson['uploadRec'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Url)));
      return Url;
    } else {
      throw Exception('Failed to post file');
    }
  }

  Future stop() async {
    if(!isRecorderReady){
      return;
    }
    final path = await recorder.stopRecorder();
    audioFile = File(path!);

    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("recorded")));
    //int ans = voiceApi.uploadAudio(path) as int;
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$ans")));
    print('Recorded path: $path');
    print('Recorded audio: $audioFile');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            body: TabBarView(
              children: [
                Center(child: Scaffold(
                  appBar:  AppBar(title: Text("하모니모",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40)),backgroundColor: Colors.white,centerTitle: true,
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<RecordingDisposition>(
                            stream: recorder.onProgress,
                              builder: (context,snapshot){
                                final duration = snapshot.hasData
                                    ? snapshot.data!.duration
                                    :Duration.zero;
                                return Text('${duration.inSeconds}s');
                              },),
                          MarimoShowApi(),
                          Container(
                            margin: EdgeInsets.fromLTRB(60, 20, 60, 0),
                            color: Color(0xffededed),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xaeffffff),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text("내 마리모 상태",style: TextStyle(color: Colors.black,fontSize: 25),),
                                  ),
                                  Container(
                                    child: MarimoStatApi(),
                                  ),
                                  TextButton(onPressed: () {
                                    Get.to(MarimoDoc());
                                  }, child: Text("마리모 잘키우는 방법",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: () async {
                            if(recorder.isRecording){
                              await stop();
                            }
                            else{
                              await record();
                            }
                            setState(() {

                            });
                          },
                              child: Container(
                                child: recorder.isRecording? Text('녹음중',style: myStyle,):Text('녹음하기',style: myStyle,),
                              ),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60)))),
                          ElevatedButton(onPressed: () async {
                            if(isPlaying){
                              await audioPlayer.pause();
                              isPlaying = false;
                            }
                            else{
                              isPlaying = true;
                              audioPlayer.setSourceUrl(audioFile.path);
                              await audioPlayer.resume();
                            }
                          },
                              child: Container(
                                child: Text('PLAY'),
                              )),
                          ElevatedButton(onPressed: () async {
                            int ans = await voiceApi.uploadVoiceFile(audioFile);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$ans")));
                          }, child: Container(
                              child: Text('SEND')))

                        ],
                      ),
                    ),
                  ),
                ),),
                Center(child: Column(),)
              ],
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Container(
              color: Color(0xFFA9CC60),
              child: Container(
                height: 100,
                padding: EdgeInsets.only(bottom: 10,top: 5),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home,size: 30),
                      text: '내 마리모 보기',
                    ),
                    Tab(
                      icon: Icon(Icons.developer_board,size: 30),
                      text: '동년배 친우들 보기',
                    ),

                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

}

