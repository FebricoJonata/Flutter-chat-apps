import 'package:chats_app/widgets/chat_messages.dart';
import 'package:chats_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');
    
    // final token = await fcm.getToken();
    // print("Ini Token : " + token!); //Token FCM
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat Application'),
          actions: [
            IconButton(
                onPressed: () {
                  _firebase.signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ))
          ],
        ),
        body: const Column(
          children: [Expanded(child: ChatMessages()), NewMessage()],
        ));
  }
}