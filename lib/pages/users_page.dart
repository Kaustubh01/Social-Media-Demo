import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/my_back_button.dart';
import 'package:wall/helpers/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(

        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot){
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return const Text("No Users");
            }

            final users = snapshot.data!.docs;
            return Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 25
                  ),
                  child: Row(
                    children: [
                      MyBackkButton(),
                    ],
                  ),
                ),

                const SizedBox(height: 25,),

                Expanded(
                  child: ListView.builder(itemCount: users.length, 
                  padding: const EdgeInsets.all(0),
                itemBuilder: (context, index){
                  final user = users[index];
                
                  return ListTile(
                    title: Text(user['username']),
                    subtitle: Text(user['email']),
                  );
                }
                ),
            )],
            );
          },
          ),
    );
  }
  }