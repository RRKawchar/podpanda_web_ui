import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:podpanda_web_ap_ui/authentication/login_screen.dart';
import 'package:podpanda_web_ap_ui/main_screen/home_page.dart';


Future<void> main()async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   // Replace with actual values
   options: FirebaseOptions(
     apiKey: "AIzaSyDB64eFic3gepTpZcZ3G9a48WlThzH9JCg",
     appId: "1:675531088988:web:b2314dc6ad6db05303f299",
     messagingSenderId: "675531088988",
     projectId: "podpanda-web-responsive",
   ),
 );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:FirebaseAuth.instance.currentUser ==null? const LoginScreen():const HomePage(),
    );
  }
}
