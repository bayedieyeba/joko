// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:joko/CustomUI/custom-card.dart';
import 'package:joko/models/chat-model.dart';
import 'package:joko/screens/select-contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatModels, required this.sourceChat})
      : super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContactPage()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (context, index) => CustomCard(
          sourceChat: widget.sourceChat,
          chatModel: widget.chatModels[index],
        ),
      ),
    );
  }
}
