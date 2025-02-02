import 'package:app_task/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController extends GetxController {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
  List<Message> messages = <Message>[].obs;
  FocusNode focusNode = FocusNode();
  void sendMessage(String message) {
    Message msg = Message(
        message: message, sender: "User", time: getCurrentTime(), isMe: true);
    messages.add(msg);
    channel.sink.add(message);
  }

  String getCurrentTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }

  @override
  void onInit() {
    channel.stream.listen((message) {
      Message msg = Message(
          message: message,
          sender: "Buyer",
          time: getCurrentTime(),
          isMe: false);
      messages.add(msg);
    });
    super.onInit();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
