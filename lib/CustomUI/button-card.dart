// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joko/models/chat-model.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, required this.nom, required this.icon})
      : super(key: key);
  final String nom;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        child: Icon(
          icon,
          size: 26,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      title: Text(nom,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
