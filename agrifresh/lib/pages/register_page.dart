import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agrifresh/components/my_buttons.dart';
import 'package:agrifresh/components/my_textfied.dart';
import 'package:agrifresh/components/SquareTile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //signUserUp
  void signUserUp()async{
    //show loading circle
    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator(),
        );
    },
    );

    //try creating the user
    try{
      //check if password is same as confirm password
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        );
      }else{
        //show error message,passwords dont match
        showErrorMessage("Passwords don't match!");
      }
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
                
                const SizedBox(height:0),
                
                //logo
                Container(
                  height:300,
                  width: 500,
                  child:Image.asset('lib/logos/Fresh2Ulogo.png'),
                ),
            
                const SizedBox(height: 0),
                
                //Login Message
                Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ),
            
                const SizedBox(height: 10),
            
                //Username Textfield
                MyTextfield(
                  controller: emailController,
                  hinText: 'Email',
                  obscureText: false,
                ),
            
              const SizedBox(height: 20),
            
                //Password Textfield
                MyTextfield(
                  controller: passwordController,
                  hinText: 'Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 20),

                //Confirm Passwrod Textfield
                MyTextfield(
                  controller: confirmPasswordController,
                  hinText: 'Confirm Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 20),
                
                //Forgot Password
                
                const SizedBox(height: 25),
            
                //Sign Up button
                MyButton(
                  text:'Sign Up',
                  onTap: signUserUp,
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
                      'Already a member?',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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