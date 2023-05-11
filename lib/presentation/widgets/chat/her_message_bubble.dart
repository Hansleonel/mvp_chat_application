import 'package:flutter/material.dart';
import 'package:mvp_chat_application/domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {
  final Message message;
  const HerMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // using the color theme with Material 3
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              message.text,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle:
                      message.text == 'Writing...' ? FontStyle.italic : null),
            ),
          ),
        ),
        const SizedBox(height: 4),
        _ImageBubble(
          imageURL: message.imageURL,
        ),
        const SizedBox(height: 4)
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String? imageURL;
  const _ImageBubble({Key? key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        imageURL ??
            'https://hotpotmedia.s3.us-east-2.amazonaws.com/8-TzVS46cWGz3LTnO.png?nc=1',
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        // using to show a loading or Widget while the image is loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: (const Text('loading image...')),
          );
        },
      ),
    );
  }
}
