import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  String message = "";
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              CupertinoButton(
                onPressed: () async {
                  final res = await supabase.auth.signInWithPassword(
                    password: password.text,
                    email: email.text,
                  );
                  message = "sign in: ${res.user?.id} | ${res.user?.email}";
                  setState(() {});
                },
                child: Text("Sign In (Kirish)"),
              ),
              CupertinoButton(
                onPressed: () async {
                  final res = await supabase.auth.signUp(
                    password: password.text,
                    email: email.text,
                  );
                  message = "sign up: ${res.user?.id} | ${res.user?.email}";
                  setState(() {});
                },
                child: Text("Sign Up (Registratsiya)"),
              ),
              Divider(),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
