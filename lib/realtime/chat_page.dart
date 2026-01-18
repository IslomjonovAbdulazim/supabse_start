import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
            stream: supabase.from("messages").stream(primaryKey: ['id']),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasData == false) {
                return Center(child: CircularProgressIndicator());
              }

              final messages = asyncSnapshot.data!;
              print(asyncSnapshot.data);
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]['text']),
                    subtitle: Text(messages[index]['created_at'].toString()),
                    leading: Text(messages[index]['id'].toString()),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
