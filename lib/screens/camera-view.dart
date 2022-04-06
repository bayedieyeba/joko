// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.crop_rotate,
              size: 27,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              size: 27,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: 27,
            )),
      ]),
      body: Container(
        height: MediaQuery.of(context).size.height - 150,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                color: Colors.black38,
                child: TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 17),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      hintText: "ajouter...",
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: 27,
                      ),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 27,
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
