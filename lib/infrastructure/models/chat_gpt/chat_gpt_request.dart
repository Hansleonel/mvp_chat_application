import 'dart:convert';

import 'chat_gpt_message.dart';

ChatGPTRequest chatGptMessagesFromJson(String str) =>
    ChatGPTRequest.fromJson(json.decode(str));

String chatGptMessagesToJson(ChatGPTRequest data) => json.encode(data.toJson());

class ChatGPTRequest {
  String model;
  List<ChatGPTMessage> messages;

  ChatGPTRequest({
    required this.model,
    required this.messages,
  });

  factory ChatGPTRequest.fromJson(Map<String, dynamic> json) => ChatGPTRequest(
        model: json['model'],
        messages: List<ChatGPTMessage>.from(json["messages"]
            .map((messageJson) => ChatGPTMessage.fromJson(messageJson))),
      );

  Map<String, dynamic> toJson() => {
        'model': model,
        'messages':
            List<dynamic>.from(messages.map((message) => message.toJson())),
      };
}
