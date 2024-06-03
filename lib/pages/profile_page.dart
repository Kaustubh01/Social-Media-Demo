import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetails() async{
    return await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).get();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future:getDetails() ,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasError){
                return Text("Error: ${snapshot.error}");
            }
            else if(snapshot.hasData){
              Map<String, dynamic>? user = snapshot.data!.data();
              return Center(
                child: Column(
                  children: [

                const Padding(
                      padding: const EdgeInsets.only(top: 50.0, left: 25),
                      child: Row(
                        children: [
                          MyBackkButton(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    padding: const EdgeInsets.all(25),
                    child: const Icon(Icons.person, size: 64,),
                  ),
                  const SizedBox(height: 25,),

                  Text(user!["username"], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Text(user["email"], style:  TextStyle(color: Colors.grey[600]),),
                ],),
              );
            }
            else{
              return const Text("No Data");
            }
          },
        ),
    );
  }
}