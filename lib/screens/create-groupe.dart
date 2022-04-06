// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:joko/CustomUI/avtar-card.dart';
import 'package:joko/CustomUI/button-card.dart';
import 'package:joko/CustomUI/contact-card.dart';
import 'package:joko/models/chat-model.dart';

class CreateGroupePage extends StatefulWidget {
  const CreateGroupePage({Key? key}) : super(key: key);

  @override
  State<CreateGroupePage> createState() => _CreateGroupePage();
}

List<ChatModel> contacts = [
  ChatModel(
      id: 0,
      nom: "Daba Diaw",
      status: "developper",
      currentMessage: '',
      icon: '',
      time: '',
      isGroup: false),
  ChatModel(
      nom: "Bara Fall",
      status: "Commerçant",
      currentMessage: '',
      icon: '',
      time: '',
      id: 1,
      isGroup: false),
  ChatModel(
      nom: "cheikh Diop",
      status: "developpe",
      currentMessage: '',
      icon: '',
      time: '',
      id: 2,
      isGroup: false)
];
List<ChatModel> groups = [];

class _CreateGroupePage extends State<CreateGroupePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nouveau group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text("ajouter un participant", style: TextStyle(fontSize: 13))
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 26),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    if (contacts[index - 1].select == true) {
                      setState(() {
                        contacts[index - 1].select = false;
                        groups.remove(contacts[index - 1]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = true;
                        groups.add(contacts[index - 1]);
                      });
                    }
                  },
                  child: ContactCard(
                    contact: contacts[index - 1],
                  ),
                );
              }),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              if (contacts[index].select) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      contacts[index].select = false;
                                      groups.remove(contacts[index]);
                                    });
                                  },
                                  child: AvtarCard(
                                    contact: contacts[index],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
