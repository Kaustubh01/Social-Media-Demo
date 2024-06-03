import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/my_button.dart';
import 'package:wall/components/my_textfields.dart';
import 'package:wall/helpers/helper_functions.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async{
    showDialog(context: context, builder: (context)=>const Center(
      child: CircularProgressIndicator(),
    ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
              SizedBox(height: 25,),
          
              Text("W A L L",style: TextStyle(fontSize: 20),),
          
              SizedBox(height: 25,),
              
              MyTextField(hintText: "Email", obsecureText: false, controller: emailController,),

              SizedBox(height: 10,),

              MyTextField(hintText: "Password", obsecureText: true, controller: passwordController,),

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  
                ],
              ),

              SizedBox(height: 25,),
              MyButton(text: "Login", onTap: login),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(" Register Here",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.inversePrimary),),
                  )
                  

                ],
              )
              
            ],
          
          ),
        ),
        ),
    );
  }
}