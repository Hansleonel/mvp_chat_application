// To parse this JSON data, do
//
//     final chatGptResponse = chatGptResponseFromJson(jsonString);

import 'dart:convert';

import '../../../domain/entities/message.dart';
import 'chat_gpt_message.dart';

ChatGPTResponse chatGptResponseFromJson(String str) =>
    ChatGPTResponse.fromJson(json.decode(str));

String chatGptResponseToJson(ChatGPTResponse data) =>
    json.encode(data.toJson());

class ChatGPTResponse {
  String id;
  String object;
  int created;
  String model;
  Usage usage;
  List<Choice> choices;

  ChatGPTResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  factory ChatGPTResponse.fromJson(Map<String, dynamic> json) =>
      ChatGPTResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        usage: Usage.fromJson(json["usage"]),
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "usage": usage.toJson(),
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };

  // normalmente esta tranformation va en una nueva capa
  Message toMessageEntity() =>
      Message(text: choices[0].message.content, fromWho: FromWho.hers);

  ChatGPTMessage toChatGPTMessage() =>
      ChatGPTMessage(role: 'assistant', content: choices[0].message.content);
}

class Choice {
  ChatGPTMessage message;
  String finishReason;
  int index;

  Choice({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        message: ChatGPTMessage.fromJson(json["message"]),
        finishReason: json["finish_reason"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "finish_reason": finishReason,
        "index": index,
      };
}

class Usage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
