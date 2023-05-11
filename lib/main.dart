import 'package:flutter/material.dart';
import 'package:mvp_chat_application/config/theme/app_theme.dart';
import 'package:mvp_chat_application/presentation/providers/chat_provider.dart';
import 'package:mvp_chat_application/presentation/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Multiplover allow use multiples providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // using the Provider ChatProvider
          create: (_) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Mvp Chat',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 2).theme(),
        home: const ChatScreen(),
      ),
    );
  }
}
