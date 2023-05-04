import 'package:flutter/material.dart';
import 'package:mvp_chat_application/presentation/widgets/chat/her_message_bubble.dart';
import 'package:mvp_chat_application/presentation/widgets/chat/my_message_bubble.dart';
import 'package:mvp_chat_application/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://hotpotmedia.s3.us-east-2.amazonaws.com/8-oc9ZLued78s4k3y.png?nc=1'),
          ),
        ),
        title: const Text('My love'),
        centerTitle: false,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return (index % 2 == 0
                      ? const HerMessageBubble()
                      : const MyMessageBubble());
                },
              ),
            ),
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}
