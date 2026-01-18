import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      final controller = TextEditingController(
                        text: messages[index]['text'],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Edit"),
                            content: TextField(controller: controller),
                            actions: [
                              CupertinoButton(
                                onPressed: () async {
                                  Get.back();
                                  await supabase
                                      .from("messages")
                                      .update({"text": controller.text})
                                      .eq('id', messages[index]['id']);
                                },
                                child: Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(messages[index]['text']),
                    subtitle: Text(messages[index]['created_at'].toString()),
                    leading: Text(messages[index]['id'].toString()),
                    trailing: CupertinoButton(
                      onPressed: () async {
                        await supabase
                            .from("messages")
                            .delete()
                            .eq('id', messages[index]['id']);
                      },
                      child: Icon(Icons.delete),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Create"),
                content: TextField(controller: controller),
                actions: [
                  CupertinoButton(
                    onPressed: () async {
                      Get.back();
                      await supabase.from("messages").insert({
                        "text": controller.text,
                      });
                    },
                    child: Text("Create"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
