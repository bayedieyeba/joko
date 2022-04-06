// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, prefer_final_fields, unused_field

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joko/CustomUI/own-message-card.dart';
import 'package:joko/CustomUI/replay-message-card.dart';
import 'package:joko/models/chat-model.dart';
import 'package:joko/models/messageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  bool sendButton = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket _socket;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    _socket = IO.io("http://localhost:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    _socket.connect();
    _socket.emit("signin", widget.sourceChat.id);
    _socket.onConnect((data) {
      print("connecté");
      _socket.on("message", (msg) {
        print(msg);
        print("docko");
        setMessage("destination", msg["message"]);
      });
    });
  }

  void envoyerMessage(String message, int sourceId, int targetId, void clear) {
    setMessage("source", message);
    print(message);
    _socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/watsapp_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup
                          ? "assets/goups.svg"
                          : "assets/person.svg",
                      color: Colors.white,
                      height: 37,
                      width: 37,
                    ),
                    radius: 20,
                    backgroundColor: Colors.grey,
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.nom,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "vu aujourd'hui à 07:15",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("Afficher contact"),
                        value: "Afficher contact",
                      ),
                      PopupMenuItem(
                        child: Text("Médias liens et documents"),
                        value: "Médias liens et documents",
                      ),
                      PopupMenuItem(
                        child: Text("Recherche"),
                        value: "Recherche",
                      ),
                      PopupMenuItem(
                        child: Text("Notification en mode silence"),
                        value: "Notification en mode silence",
                      ),
                      PopupMenuItem(
                        child: Text("Fond d'écran"),
                        value: "Fond d'écran",
                      )
                    ];
                  })
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                              message: messages[index].message);
                        } else {
                          return ReplayMessageCard(
                              message: messages[index].message);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: _controller,
                                  focusNode: focusNode,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message",
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.emoji_emotions),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomsheet());
                                              },
                                              icon: Icon(Icons.attach_file)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.camera_alt))
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8,
                                right: 5,
                                left: 2,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 25,
                                child: IconButton(
                                  icon:
                                      Icon(sendButton ? Icons.send : Icons.mic),
                                  onPressed: () {
                                    if (sendButton) {
                                      print("bbbb");
                                      envoyerMessage(
                                          _controller.text,
                                          widget.sourceChat.id,
                                          widget.chatModel.id,
                                          _controller.clear());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        show ? emoji_selectionne() : Container()
                      ],
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  creation_icone(
                      Icons.insert_drive_file, Colors.blue, "Documents"),
                  SizedBox(width: 40),
                  creation_icone(Icons.camera_alt, Colors.pink, "Caméra"),
                  SizedBox(width: 40),
                  creation_icone(Icons.insert_photo, Colors.blue, "Gallery"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  creation_icone(Icons.headset, Colors.orange, "Audios"),
                  SizedBox(width: 40),
                  creation_icone(Icons.location_pin, Colors.pink, "Caméra"),
                  SizedBox(width: 40),
                  creation_icone(Icons.person, Colors.blue, "Gallery"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget creation_icone(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(text, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  Widget emoji_selectionne() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        });
  }
}
