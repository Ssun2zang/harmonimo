import 'package:flutter/material.dart';

import 'friendDetail.dart';

class Friend {
  final int userId;
  final String name;
  final int age;
  final String profileImageUrl;

  Friend({
    required this.userId,
    required this.name,
    required this.age,
    required this.profileImageUrl,
  });
}

class FriendWidget extends StatelessWidget {
  final List<Friend> friends = [
    Friend(userId: 18, name: '김의명 할아버지', age: 81, profileImageUrl: 'URL_1'),
    Friend(userId: 19, name: '백전문 할아버지', age: 68, profileImageUrl: 'URL_2'),
    Friend(userId: 20, name: '윤종익 할아버지', age: 63, profileImageUrl: 'URL_3'),
    Friend(userId: 21, name: '유이선 할머니', age: 65, profileImageUrl: 'URL_4'),
    Friend(userId: 22, name: '조춘걸 할아버지', age: 59, profileImageUrl: 'URL_5'),
  ];

  void _showFriendDetailPage(BuildContext context, Friend friend) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FriendDetailPage(friend: friend),
      ),
    );
  }

  void _sendVoiceMessage(Friend friend) {
    // 구현 필요
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: friends.map((friend) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                // 친구 정보 표시
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      _showFriendDetailPage(context, friend);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(friend.profileImageUrl),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend.name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '나이: ${friend.age}세',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 음성 메시지 보내기 버튼
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {
                      _sendVoiceMessage(friend);
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

