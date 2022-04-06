// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:joko/models/chat-model.dart';
import 'package:joko/pages/Chat-page.dart';
import 'package:joko/pages/camera-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.chatModels, required this.sourceChat})
      : super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Joko"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Nouveau groupe"),
                      value: "Nouveau groupe",
                    ),
                    PopupMenuItem(
                      child: Text("Nouvelle diffusion"),
                      value: "Nouvelle diffusion",
                    ),
                    PopupMenuItem(
                      child: Text("appareil connecte"),
                      value: "appareil connecte",
                    ),
                    PopupMenuItem(
                      child: Text("commencer message"),
                      value: "Commencer message",
                    ),
                    PopupMenuItem(
                      child: Text("Parametre"),
                      value: "Parametre",
                    )
                  ];
                })
          ],
          bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Messages",
              ),
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(
                text: "Appels",
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ChatPage(
              chatModels: widget.chatModels,
              sourceChat: widget.sourceChat,
            ),
            CameraPage(),
            Text("Appels"),
          ],
        ));
  }
}
