import 'package:agrifresh/pages/home_page.dart';
import 'package:agrifresh/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user logged in
          if(snapshot.hasData){
            return HomePage();
          }
          //user is NOT logged in          
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}