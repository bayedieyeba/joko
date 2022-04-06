// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:joko/CustomUI/button-card.dart';
import 'package:joko/CustomUI/contact-card.dart';
import 'package:joko/models/chat-model.dart';
import 'package:joko/screens/create-groupe.dart';

class SelectContactPage extends StatefulWidget {
  const SelectContactPage({Key? key}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPage();
}

class _SelectContactPage extends State<SelectContactPage> {
  @override
  Widget build(BuildContext context) {
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
          id: 1,
          nom: "Bara Fall",
          status: "Commerçant",
          currentMessage: '',
          icon: '',
          time: '',
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
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text("120 contacts", style: TextStyle(fontSize: 13))
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 26),
          ),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Inviter un(e) ami(e)"),
                    value: "Inviter un(e) ami(e)",
                  ),
                  PopupMenuItem(
                    child: Text("contacts"),
                    value: "contats",
                  ),
                  PopupMenuItem(
                    child: Text("actualiser"),
                    value: "actualiser",
                  ),
                  PopupMenuItem(
                    child: Text("Aide"),
                    value: "aide",
                  ),
                ];
              })
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CreateGroupePage()));
                },
                child: ButtonCard(
                  icon: Icons.group,
                  nom: "nouveau groupe",
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                nom: "nouveau contact",
              );
            } else {
              return ContactCard(
                contact: contacts[index - 2],
              );
            }
          }),
    );
  }
}
