import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agrifresh/components/my_buttons.dart';
import 'package:agrifresh/components/my_textfied.dart';
import 'package:agrifresh/components/SquareTile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //signUserIn
  void signUserIn()async{
    //show loading circle
    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator(),
        );
    },
    );

    //try sign in
    try{
      await FirebaseAuth.instance
      .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        );
      //remove loading circle
      Navigator.pop(context);        
    }on FirebaseAuthException catch(e){
      //remove loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green[300],
      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:[
                
                const SizedBox(height:5),
                
                //logo
                Container(
                  height:300,
                  width: 500,
                  child:Image.asset('lib/logos/Fresh2Ulogo.png'),
                ),
            
                const SizedBox(height: 0),
                
                //Login Message
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ),
            
                const SizedBox(height: 20),
            
                //Username Textfield
                MyTextfield(
                  controller: emailController,
                  hinText: 'Email',
                  obscureText: false,
                ),
            
              const SizedBox(height: 30),
            
                //Password Textfield
                MyTextfield(
                  controller: passwordController,
                  hinText: 'Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 20),
                //Forgot Password
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style:TextStyle(
                          color: Colors.black,
                          fontSize: 15)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
            
                //Sign in button
                MyButton(
                  text:'Sign In',
                  onTap: signUserIn,
                ),
            
                const SizedBox(height:20),
            
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height:30),
            
                //alternative sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/logos/google_logo.png'),
            
                  ],
                ),
            
                const SizedBox(height: 50),          
                //register
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                 )             
              ],
            ),
          ),
        ),
      )
    );
  }
}