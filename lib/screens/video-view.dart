// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

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
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
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
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
