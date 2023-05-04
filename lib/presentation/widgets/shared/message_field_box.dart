import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    final focusNode = FocusNode();
    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16));
    final inputDecoration = InputDecoration(
        hintText: 'use a question please',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            print('icon pressed');
            print('value with button pressed ${messageController.text}');
            messageController.clear();
          },
        ));
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        onTapOutside: (event) => focusNode.unfocus(),
        focusNode: focusNode,
        controller: messageController,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          print('onField submitted value $value');
          messageController.clear();
          focusNode.requestFocus();
        },
      ),
    );
  }
}
