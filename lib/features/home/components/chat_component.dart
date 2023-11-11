import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hybrid/models/chat_message.dart';
import 'package:hybrid/theme/t_constants.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({Key? key}) : super(key: key);

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final List<ChatMessage> msgdata = List.generate(
    25,
    (index) => ChatMessage(
      sender: Random().nextInt(2) == 0 ? '1' : '2',
      message:
          'This is message $index ${Random().nextInt(2) == 0 ? 'Hey, how are you doing?' : 'Hey, how '}',
      timestamp: DateTime.now().subtract(Duration(minutes: index)),
    ),
  );

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _profileDetailsBuilder(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Expanded(
                      child: MessageBubble(
                        message: msgdata[index].message,
                        isMe: msgdata[index].sender == '1',
                      ),
                    ),
                    itemCount: msgdata.length,
                  ),
                ],
              ),
            ),
          ),
          messageInputBox(),
        ],
      ),
    );
  }

   messageInputBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.attach_file),
              color: Colors.grey,
              padding: EdgeInsets.zero,
            ),
            Expanded(
              child: TextFormField(
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Transform.rotate(
              angle: 0.785398,
              child: FloatingActionButton.small(
                backgroundColor: AppColorConstants.black,
                onPressed: () {},
                child: Transform.rotate(
                  angle: -1.6,
                  child: Icon(
                    Icons.send_outlined,
                    color: AppColorConstants.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _profileDetailsBuilder() {
    return Container(
      height: 250,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColorConstants.mainThemeColor,
          borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          Positioned(
            left: -160,
            top: 120,
            child: Transform.rotate(
              angle: 60 * 3.141 / 180,
              child: Container(
                width: 470,
                height: 465,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(152),
                    border: Border.all(color: AppColorConstants.white)),
              ),
            ),
          ),
          Positioned(
            left: -140,
            top: 80,
            child: Transform.rotate(
              angle: 60 * 3.141 / 180,
              child: Container(
                width: 470,
                height: 465,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(152),
                    border: Border.all(color: AppColorConstants.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;

  const MessageBubble({super.key, required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isMe ? AppColorConstants.lightRed : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: isMe ? Radius.zero : const Radius.circular(18),
                topLeft: isMe ? const Radius.circular(18) : Radius.zero,
                bottomLeft: const Radius.circular(18),
                bottomRight: const Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
