import 'package:flutter/material.dart';
import 'package:mvp_chat_application/domain/entities/message.dart';
import 'package:mvp_chat_application/presentation/providers/chat_provider.dart';
import 'package:mvp_chat_application/presentation/widgets/chat/her_message_bubble.dart';
import 'package:mvp_chat_application/presentation/widgets/chat/my_message_bubble.dart';
import 'package:mvp_chat_application/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

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
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messageList[index];

                  return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble(message: message)
                      : MyMessageBubble(message: message);
                },
              ),
            ),
            MessageFieldBox(
                // onValue: (String value) => chatProvider.sendMessage(value)),
                onValue: (String value) =>
                    chatProvider.sendMessageChatGPT(value)),
          ],
        ),
      ),
    );
  }
}
