class ChatGPTMessage {
  String role;
  String content;

  ChatGPTMessage({
    required this.role,
    required this.content,
  });

  factory ChatGPTMessage.fromJson(Map<String, dynamic> json) => ChatGPTMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
