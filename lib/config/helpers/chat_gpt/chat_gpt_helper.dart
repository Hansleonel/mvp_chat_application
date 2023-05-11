import 'package:dio/dio.dart';
import 'package:mvp_chat_application/infrastructure/models/chat_gpt/chat_gpt_request.dart';
import 'package:mvp_chat_application/infrastructure/models/chat_gpt/chat_gpt_response.dart';

class ChatGPTHelper {
  Future<ChatGPTResponse> getChatGPTReplyMessage(ChatGPTRequest request) async {
    const String apiKey = '';
    const String apiUrl = 'https://api.openai.com/v1/chat/completions';

    // Configura Dio con la clave API y la URL de la API
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    final response = await dio.post(apiUrl, data: request.toJson());

    final chatGPTResponse = ChatGPTResponse.fromJson(response.data);

    return chatGPTResponse;
  }
}
