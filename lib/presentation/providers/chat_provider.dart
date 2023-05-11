import 'package:flutter/material.dart';
import 'package:mvp_chat_application/config/helpers/answer_yes_no_helper.dart';
import 'package:mvp_chat_application/domain/entities/message.dart';
import 'package:mvp_chat_application/infrastructure/models/chat_gpt/chat_gpt_request.dart';

import '../../config/helpers/chat_gpt/chat_gpt_helper.dart';
import '../../infrastructure/models/chat_gpt/chat_gpt_message.dart';
import '../../infrastructure/models/chat_gpt/chat_gpt_response.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messageList = [];
  List<ChatGPTMessage> meesageChatGPTList = [
    ChatGPTMessage(role: 'system', content: 'eres un experto en flutter')
  ];

  final chatScrollController = ScrollController();
  final answerYesNoHelper = AnswerYesNoHelper();
  final chatGPTHelper = ChatGPTHelper();

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final newMessage = Message(text: message, fromWho: FromWho.mine);
    messageList.add(newMessage);

    if (message.endsWith('?')) {
      getHerReplyMessage();
    }

    notifyListeners();
    // como este metodo maneja internamente la actualizacion de la posicion de la lista
    // ListView.Builder() es recomendado utilizarlo una vez se actualice la pantalla con el uso del
    // notifyListeners() porque se tendra la actualizacion del size de la lista y se sabra hasta donde
    // tiene que moverse con dicho size
    moveScrollToBottom();
  }

  Future<void> sendMessageChatGPT(String requestPerson) async {
    if (requestPerson.isEmpty) return;
    final newMessage = Message(text: requestPerson, fromWho: FromWho.mine);
    messageList.add(newMessage);
    getChatGPTReplyMessage(requestPerson);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> getHerReplyMessage() async {
    addWaintgHerMessage();
    final herMessage = await answerYesNoHelper.getHerReplyMessage();
    messageList.removeLast();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> getChatGPTReplyMessage(String requestPerson) async {
    // agrega el await con los puntos
    addWaintgHerMessage();
    // crea una instancia de ChatGPTMessage que tiene que ser almancenada en memoria en tiempo de ejecucion
    // y posteriormente guardada en la memoria interna usando un DB como hive para darle contexto a chatgpt
    ChatGPTMessage chatGPTMessage =
        ChatGPTMessage(role: 'user', content: requestPerson);
    // almacenando en memoria en tiempo de ejecucion
    meesageChatGPTList.add(chatGPTMessage);

    // haciendo la peticion con el conjuto de respuesta y solicitudes con el nombre de "messageChatGPTList"
    // y recibiendo la respuesta
    ChatGPTResponse chatGPTResponse =
        await chatGPTHelper.getChatGPTReplyMessage(ChatGPTRequest(
            model: 'gpt-3.5-turbo', messages: meesageChatGPTList));

    try {
      // usando el metodo "toChatGPTMessage" para instanciar un nuevo objeto del tipo ChatGPTMessage
      ChatGPTMessage chatGPTMessageResponse =
          chatGPTResponse.toChatGPTMessage();
      // agregando esa respuesta a nuestro listado de contexto
      meesageChatGPTList.add(chatGPTMessageResponse);

      messageList.removeLast();
      messageList.add(chatGPTResponse.toMessageEntity());
    } catch (e, s) {
      messageList.removeLast();
      messageList.add(Message(
          text: 'error en la respuesta del tipo $e y $s',
          fromWho: FromWho.hers));
    }
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async {
    // Al agregar await Future.delayed(const Duration(milliseconds: 100));,
    // estás introduciendo un pequeño retraso antes de que se inicie la animación del desplazamiento.
    // Este retraso permite que Flutter tenga tiempo suficiente para recalcular maxScrollExtent en función de los elementos recién renderizados.
    // Con el valor correcto de maxScrollExtent, la animación del desplazamiento se realizará correctamente y la lista se desplazará al final.
    await Future.delayed(const Duration(milliseconds: 100));
    // cuando el controlador de desplazamiento actualiza su posición durante la animación,
    // el ListView.builder se actualiza automáticamente sin que tengas que usar alguno manejador de estados
    // que actualice o renderice el screen en este caso la lista
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  void addWaintgHerMessage() {
    Message waitingHerMessage =
        Message(text: 'Writing...', fromWho: FromWho.hers);
    messageList.add(waitingHerMessage);
    notifyListeners();
    moveScrollToBottom();
  }
}
