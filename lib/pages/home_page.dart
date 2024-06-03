import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  void logout(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        actions: [
          
        ],
      ),
      drawer:MyDrawer(),

    );
  }
}