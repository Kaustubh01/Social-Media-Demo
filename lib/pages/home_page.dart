import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/my_drawer.dart';
import 'package:wall/components/my_post_button.dart';
import 'package:wall/components/my_textfields.dart';
import 'package:wall/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  void postMessage(){
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("H O M E")),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),

      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              Expanded(
                child: MyTextField(hintText: "Say something", obsecureText: false, controller: newPostController)
              ),

              PostButton(onTap: postMessage)
            ],
          ),
        ),

        StreamBuilder(stream: database.getPostsStream(), builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final posts = snapshot.data!.docs;
          if (snapshot.data == null || posts.isEmpty) {
            return const Center(
              
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text("No Posts...."),
                ),
            );
          }

          return Expanded(child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
                final post  = posts[index];
                String message = post['PostMessage'];
                String userEmail = post['UserEmail'];
                Timestamp timestamp = post['TimeStamp'];

                return Padding(
                  padding: const EdgeInsets.only(left:25.0, right: 25, bottom: 25),
                  child: ListTile(
                    title: Text(message),
                    subtitle: Text(userEmail, style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                  ),
                );
          }));
        })
      ],),

    );
  }
}