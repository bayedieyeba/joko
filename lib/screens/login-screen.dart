// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:joko/CustomUI/button-card.dart';
import 'package:joko/models/chat-model.dart';
import 'package:joko/screens/Home-page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
        nom: "Docko sow",
        icon: "person.svg",
        isGroup: false,
        time: "13:20",
        currentMessage: "bégué nala baye",
        status: '',
        id: 1),
    ChatModel(
        nom: "Cheikh BA",
        icon: "person.svg",
        isGroup: false,
        time: "14:20",
        currentMessage: "fall nakamou",
        status: '',
        id: 2),
    ChatModel(
        nom: "Astou Seck",
        icon: "person.svg",
        isGroup: false,
        time: "11:30",
        currentMessage: "coucou",
        status: '',
        id: 3),
    ChatModel(
        nom: "Demba",
        icon: "person.svg",
        isGroup: false,
        time: "10:20",
        currentMessage: "bégué",
        status: '',
        id: 4),
    ChatModel(
        nom: "Fatou",
        icon: "person.svg",
        isGroup: false,
        time: "13:22",
        currentMessage: "Hello",
        status: '',
        id: 5)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => HomePage(
                          chatModels: chatModels,
                          sourceChat: sourceChat,
                        )));
          },
          child: ButtonCard(nom: chatModels[index].nom, icon: Icons.person),
        ),
      ),
    );
  }
}
