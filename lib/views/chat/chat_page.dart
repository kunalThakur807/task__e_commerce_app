import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/websocket_controller.dart';

class ChatPage extends GetView<WebSocketController> {
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ChatInputBar(
        controller: messageController,
        onSend: () {
          controller.sendMessage(messageController.text);
          messageController.clear();
        },
      ),
      appBar: AppBar(
          title: Text('Chat',
              style: Responsive.isDesktop(context)
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleSmall)),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: controller.messages
                      .map((msg) => MessageText(
                            message: msg.message,
                            sender: msg.sender,
                            time: msg.time,
                            isMe: msg.isMe,
                          ))
                      .toList())),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  ChatInputBar({
    Key? key,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (v) {
                onSend();
              },
              controller: controller,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                fillColor: purpleColor.withOpacity(0.1),
                hintText: "Type a message...",
                hintStyle: const TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CircleAvatar(
            backgroundColor: purpleColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: onSend,
            ),
          )
        ],
      ),
    );
  }
}

class MessageText extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  MessageText({
    Key? key,
    required this.sender,
    required this.message,
    required this.time,
    this.isMe = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        children: [
          if (isMe) const Expanded(child: SizedBox()),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isMe ? purpleColor.withOpacity(0.25) : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: isMe ? const Radius.circular(10) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          if (!isMe) const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
