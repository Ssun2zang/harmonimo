import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/API/marimoShow_api.dart';
import 'package:harmonimo/API/marimoStat_api.dart';
import 'package:harmonimo/MyController.dart';
import 'package:harmonimo/marimoEmo.dart';
import 'package:harmonimo/marimodoc.dart';
import 'package:harmonimo/marimoDeco.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          //appBar: AppBar(title: Text("홈",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),
            //automaticallyImplyLeading: false,centerTitle: true,backgroundColor: Colors.white,),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBar(title: Text("홈",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
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
                      child: Expanded(
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
                      ),
                    )
                  ],

                ),
              ),
              Center(child: Column(
                children: [
                  AppBar(title: Text("공동 게시판",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),


                ],
              )),
              Center(child: Column(
                children: [
                  AppBar(title: Text("친구 관리",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Container(

                  ),
                ],
              )),
              Center(child: Column(
                children: [
                  AppBar(title: Text("내 정보",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),

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
                    icon: Icon(Icons.developer_board),
                    text: '공동 게시판',
                  ),
                  Tab(
                    icon: Icon(Icons.emoji_people),
                    text: '친구 관리',
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

    );
  }
}
