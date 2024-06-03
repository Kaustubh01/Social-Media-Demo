import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Icon(Icons.favorite)),
              
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(leading: Icon(Icons.home), 
                title: Text("H O M E"),
                onTap: () {
                   Navigator.pop(context);
                },
                ),
              ),
              
              
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(leading: Icon(Icons.person), 
                title: Text("P R O F I L E"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile_page');
                },
                ),
              ),
              
              
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(leading: Icon(Icons.group), 
                title: Text("U S E R S"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/users_page');
                },
                ),
              ),
            ],
          ),


          const SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(leading: Icon(Icons.logout), 
            title: Text("L O G O U T"),
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
            ),
          )
        ],
      ),
    );
  }
}