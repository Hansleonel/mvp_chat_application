import 'package:dio/dio.dart';
import 'package:mvp_chat_application/domain/entities/message.dart';
import 'package:mvp_chat_application/infrastructure/models/yes_no_model.dart';

class AnswerYesNoHelper {
  final _dio = Dio();

  Future<Message> getHerReplyMessage() async {
    final response = await _dio.get('https://yesno.wtf/api');
    final yesNoModel = YesNoModel.fromJson(response.data);
    return yesNoModel.toMessageEntity();
  }
}
