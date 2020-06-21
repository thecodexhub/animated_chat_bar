import 'package:flutter/material.dart';
import 'package:animatedchatbar/animated_chat_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Chat Bar',
      home: AnimatedChatBar(),
    );
  }
}