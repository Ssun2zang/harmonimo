import 'package:flutter/material.dart';

import 'friends.dart';

class FriendDetailPage extends StatelessWidget {
  final Friend friend;

  FriendDetailPage({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 상세 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(friend.profileImageUrl),
            ),
            SizedBox(height: 16),
            Text(
              friend.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '나이: ${friend.age}세',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '유저 ID: ${friend.userId}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
