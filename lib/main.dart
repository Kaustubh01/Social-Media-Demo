import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wall/auth/auth.dart';
import 'package:wall/auth/login_or_register.dart';
import 'package:wall/pages/home_page.dart';
import 'package:wall/pages/profile_page.dart';
import 'package:wall/pages/users_page.dart';
import 'package:wall/theme/dark_mode.dart';
import 'package:wall/theme/light_mode.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login_register_page':(context)=> const LoginOrRegister(),
        '/home_page':(context)=>  HomePage(),
        '/profile_page':(context)=>  ProfilePage(),
        '/users_page':(context)=> const UsersPage(),
      },
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
