import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/API/marimoStat_api.dart';
import 'package:harmonimo/API/voice_api.dart';
import 'package:harmonimo/MyController.dart';
import 'package:harmonimo/marimoEmo.dart';
import 'package:harmonimo/marimodoc.dart';
import 'package:harmonimo/marimoDeco.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final recorder = FlutterSoundRecorder();
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isRecorderReady = false;
  File audioFile = File('');
  VoiceApi voiceApi = VoiceApi();
  FlutterTts flutterTts = FlutterTts();
  List<Message> msgList = [];

  final MyController myController = Get.put(MyController());

  TextStyle myStyle = TextStyle(fontSize: 20,color: Colors.black);

  @override
  void initState(){
    super.initState();
    flutterTts.setLanguage("ko-KR"); // 사용할 언어 설정
    flutterTts.setSpeechRate(0.5); // 말하는 속도 설정 (1.0이 기본값)
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
    return Obx(() =>MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              Center(
                child: Scaffold(
                    appBar:AppBar(title: Text("홈",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                    body:SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 253,
                              height: 141,
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
                                      child: Text("마리모 닥터"),
                                    ),
                                    Container(
                                      child: MarimoStatApi(),
                                    ),
                                    TextButton(onPressed: () {
                                      Get.to(MarimoDoc());
                                    }, child: Text("자세히보기",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),))

                                  ],
                                ),
                              ),
                            ),
                            Container(
                                child: MarimoShowApi()
                            ),
                            Container(
                              child: Column(
                                children: [
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
                                    String ans = await voiceApi.uploadVoiceFile(audioFile,100);
                                    voiceApi.uploadUrlOther(ans, 1,myController.Id.value);
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
                                    msgList = await voiceApi.getMessages(100);
                                    int len = msgList.length;
                                    await _speak("지금까지 $len 개의 소식이 왔습니다.");
                                    for(int i =0;i<len;i++){
                                      //print(msgList[i].id);
                                      //String name= await voiceApi.getName(msgList[i].id);
                                      //print(name);
                                      if(msgList[i].url!=''){
                                        await _speak("$i 번째 소식입니다. 김갑수 어르신으로 부터 소식입니다.");
                                        await audioPlayer.play(UrlSource(msgList[i].url));
                                        await audioPlayer.onPlayerComplete.first;
                                        //await _speak('여기까지입니다.');
                                      }
                                    }
                                  }, child: Container(
                                      child: Text('소식 듣기',style: myStyle,)),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFA9CC60))),),


                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: OutlinedButton(onPressed: () {
                                      Get.to(MarimoDeco());
                                    }, child: Container(
                                      height: 80,
                                      width: 60,
                                      child: Column(
                                        children: [
                                          Image.asset('assets/image/star.PNG'),
                                          Text("꾸미기>",style: TextStyle(color: Colors.black),)
                                        ],
                                      ),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: OutlinedButton(onPressed: () {
                                      Get.to(MarimoEmo());

                                    }, child: Container(
                                      height: 80,
                                      width: 60,
                                      child: Column(
                                        children: [
                                          Image.asset('assets/image/emoji.PNG'),
                                          Text("감정표현>",style: TextStyle(color: Colors.black),)
                                        ],
                                      ),
                                    )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                ),
              ),
              Center(child: Column(
                children: [
                  AppBar(title: Text("사용 기록",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Container(
                    color: Color(0xcbeaffaa),
                    decoration: BoxDecoration(
                        border: Border.all(
                        color: Color(0x743eaa00), // 테두리 색상
                        width: 2.0, // 테두리 두께
                      ),
                      borderRadius: BorderRadius.circular(10.0),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.person,size: 40),
                            Text('${myController.name.value} 어르신\n최근 접속기록',style: myStyle,),
                          ],
                        ),
                        Column(

                          children: [
                            Text('${myController.recentYear.value}년\n${myController.recentMonth.value}월\n${myController.recentDay.value}일',style: myStyle,),
                            Text('${myController.recentId.value}',style: myStyle,)
                          ],
                        )
                      ],
                    ),

                  ),
                ],
              )),
              Center(child: Column(
                children: [
                  AppBar(title: Text("내 정보",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Container(
                  )
                ],
              )),
            ],

          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            color: Color(0xFFA9CC60),
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 10,top: 5),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 13),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: '홈',
                  ),
                  Tab(
                    icon: Icon(Icons.emoji_people),
                    text: '사용 기록',
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: '내 정보',
                  ),

                ],
              ),
            ),
          ),

        ),
      )
      ,

    ));
  }
}
