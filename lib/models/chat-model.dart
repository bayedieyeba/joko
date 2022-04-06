// ignore_for_file: file_names

class ChatModel {
  String nom;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool select = false;
  int id;

  ChatModel(
      {required this.nom,
      required this.icon,
      required this.isGroup,
      required this.time,
      required this.currentMessage,
      required this.status,
      required this.id,
      this.select = false});
}
