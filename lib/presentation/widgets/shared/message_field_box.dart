import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  // esta propiedad se activa cuando se utiliza el submit del TextFormField
  // o cuando se hace onPressed en el icon esto se puede personalizar,
  // ademas esta propiedad siempre devuelve un valor
  // en este caso un String, aunque dicho tipo puede ser personalizado
  // podriamos hacer el llamado del provider directamente para usar el metodo sendMessage
  // pero hariamos que el widget solo sea utilizable con ese provider
  // es por eso que usamos la propiedad onValue del tipo ValueChanged
  final ValueChanged<String> onValue;
  const MessageFieldBox({Key? key, required this.onValue}) : super(key: key);

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
            final textValue = messageController.text;
            onValue(textValue);
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
          onValue(value);
          messageController.clear();
          focusNode.requestFocus();
        },
      ),
    );
  }
}
