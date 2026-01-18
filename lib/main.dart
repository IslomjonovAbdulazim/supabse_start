import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabse_start/auth/email_page.dart';
import 'package:supabse_start/realtime/chat_page.dart';

String url = "https://ukuwkkancuwlbzxtoeud.supabase.co";
String anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrdXdra2FuY3V3bGJ6eHRvZXVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg0ODk1NzIsImV4cCI6MjA4NDA2NTU3Mn0.5lfBCCCDLa4iv5wKAIGQuuhINYO5w-Tzjt4JXSGhWB4";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}
