import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:harmonimo/API/friend_api.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/API/marimoStat_api.dart';
import 'package:harmonimo/API/voice_api.dart';
import 'package:harmonimo/marimodoc.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:harmonimo/MyController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  final myController = Get.find<MyController>();

  FlutterTts flutterTts = FlutterTts();
  List<Message> msgList = [];
  final List<String> friends = [
    '김춘배',
    '김도화',
    '장혜정',
  ];
  String friendName='';
  int friendId = 0;
  @override
  void initState(){
    super.initState();
    flutterTts.setLanguage("ko-KR"); // 사용할 언어 설정
    flutterTts.setSpeechRate(0.3); // 말하는 속도 설정 (1.0이 기본값)
    flutterTts.setVolume(1.0); // 소리 볼륨 설정 (0.0 ~ 1.0)
    flutterTts.setPitch(1.0); // 음성 톤 설정 (0.5 ~ 2.0)
    flutterTts.awaitSpeakCompletion(true);
    initRecorder();
  }

  @override
  void dispose(){
    recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text); // 텍스트를 음성으로 변환하고 재생
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



  Future stop() async {
    if(!isRecorderReady){
      return;
    }
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    recorder.recordingData();
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
                          /*StreamBuilder<RecordingDisposition>(
                            stream: recorder.onProgress,
                              builder: (context,snapshot){
                                final duration = snapshot.hasData
                                    ? snapshot.data!.duration
                                    :Duration.zero;
                                return Text('${duration.inSeconds}s');
                              },),*/
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
                          /*ElevatedButton(onPressed: () async {
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
                              )),*/
                          ElevatedButton(onPressed: () async {
                            String ans = await voiceApi.uploadVoiceFile(audioFile,myController.Id.value);
                            myController.current.value +=1;
                            voiceApi.uploadUrlElder(ans, myController.Id.value);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$ans")));
                            showDialog(
                                context: context,
                                //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    //Dialog Main Title
                                    title: Column(
                                      children: <Widget>[
                                        new Text("소식 보내기"),
                                      ],
                                    ),
                                    //
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "소식 보내기 완료!",
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      new ElevatedButton(
                                        child: new Text("확인"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }, child: Container(
                              child: Text('목소리 보내기',style: myStyle,)),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60))),),
                          ElevatedButton(onPressed: () async {
                            msgList = await voiceApi.getMessages(myController.Id.value);
                            int len = msgList.length;
                            await _speak("지금까지 $len 개의 소식이 왔습니다.");
                            for(int i =0;i<len;i++){
                              //print(msgList[i].id);
                              //String name= await voiceApi.getName(msgList[i].id);
                              //print(name);
                              if(msgList[i].url!=''){
                                await _speak("$i 번째 소식입니다. 보호자으로 부터 소식입니다.");
                                await audioPlayer.play(UrlSource(msgList[i].url));
                                await audioPlayer.onPlayerComplete.first;
                                //await _speak('여기까지입니다.');
                              }
                            }
                            /*if(isPlaying){
                              await audioPlayer.pause();
                              isPlaying = false;
                            }
                            else{
                              isPlaying = true;
                              audioPlayer.setSourceUrl(audioUrl);
                              await audioPlayer.resume();
                            }*/

                          }, child: Container(
                              child: Text('소식 듣기',style: myStyle,)),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60))),),

                        ],
                      ),
                    ),
                  ),
                ),),
                Center(child: Scaffold(
                  appBar: AppBar(title: Text("내 친우들",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40)),backgroundColor: Colors.white,centerTitle: true,
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          ElevatedButton(onPressed: () {
                            setState(() {
                              friendId = 1;
                              friendName = '김춘배';
                            });

                          }, style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),child: FriendShowApi(emoji: 1, hat: 3, face: 3, pet: 2, name: '김춘배',stat: '어제',)),
                          ElevatedButton(onPressed: () {
                            setState(() {
                              friendId = 2;
                              friendName = '김도화';
                            });

                          }, style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),child: FriendShowApi(emoji: 2, hat: 2, face: 2, pet: 3, name: '김도화',stat: '오늘',)),
                          ElevatedButton(onPressed: () {
                            setState(() {
                              friendId = 4;
                              friendName = '장혜정';
                            });

                          }, style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),child: FriendShowApi(emoji: 3, hat: 1, face: 1, pet: 1, name: '장혜정',stat: '오늘',)),

                          Container(
                            child: Text('$friendName에게 소식 전달하기',style: TextStyle(fontSize: 30)),
                          ),
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
                            String ans = await voiceApi.uploadVoiceFile(audioFile,myController.Id.value);
                            myController.current.value +=1;
                            voiceApi.uploadUrlOther(ans, myController.Id.value,friendId);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$ans")));
                            showDialog(
                                context: context,
                                //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    //Dialog Main Title
                                    title: Column(
                                      children: <Widget>[
                                        new Text("소식 보내기"),
                                      ],
                                    ),
                                    //
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "소식 보내기 완료!",
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      new ElevatedButton(
                                        child: new Text("확인"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }, child: Container(
                              child: Text('목소리 보내기',style: myStyle,)),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60))),),


                        ]

                      ),
                    ),
                  ),
                ),)
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

