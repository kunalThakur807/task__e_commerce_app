class Message {
  final String sender;
  final String message;
  final String time;
  final bool isMe;
  Message({
    required this.sender,
    required this.message,
    required this.time,
    this.isMe = false,
  });
}
