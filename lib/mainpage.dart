import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBar(title: Text("홈",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                      Container(
                        width: 253,
                        height: 141,
                        margin: EdgeInsets.fromLTRB(60, 20, 60, 0),
                        color: Color(0xffededed),
                        child: Column(
                          children: [
                            Container(
                              child: Text("마리모 닥터"),
                            ),
                            Container(
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("빛"),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    ),
                                    Container(
                                      child: Text("좋아요!"),margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("온도"),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    ),
                                    Container(
                                      child: Text("좋아요!"),margin: EdgeInsets.fromLTRB(00, 0, 20, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("수질"),margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    ),
                                    Container(
                                      child: Text("갈아주세요!"),margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            TextButton(onPressed: () {

                            }, child: Text("자세히보기",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),))

                          ],
                        ),
                      ),
                      Container(
                        child: Image.asset('assets/image/mainMarimo.PNG'),
                      ),
                      Container(
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: OutlinedButton(onPressed: () {
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
              ),
              Center(child: Column(
                children: [
                  AppBar(title: Text("공동 게시판",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Text("아직"),
                ],
              )),
              Center(child: Column(
                children: [
                  AppBar(title: Text("친구 관리",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Text("덜"),
                ],
              )),
              Center(child: Column(
                children: [
                  AppBar(title: Text("내 정보",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.white,centerTitle: true,),
                  Text("만듬"),
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
