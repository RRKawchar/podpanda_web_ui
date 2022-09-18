import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podpanda_web_ap_ui/main_screen/home_page.dart';
import 'package:podpanda_web_ap_ui/utils/app_colors.dart';
import 'package:podpanda_web_ap_ui/utils/reusable_text.dart';
import 'package:podpanda_web_ap_ui/utils/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email="";
  String password="";

   AllowAdminToLogin()async{

     final snackbar=SnackBar(
       backgroundColor: pinkAccenColor,
       content: ReusableText(text: "Checking Credentials, Please wait......",size: 36,color: blackColor,),
       duration:const Duration(seconds: 6),
     );
     ScaffoldMessenger.of(context).showSnackBar(snackbar);

     User? currentAdmin;

     await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email, 
         password: password
     ).then((fAuth){
       currentAdmin=fAuth.user;
     } ).catchError((onError){

       final snackbar=SnackBar(
            backgroundColor: pinkAccenColor,
           content: ReusableText(text: "Error Occured $onError",size: 36,color: blackColor,),
         duration:const Duration(seconds: 5),
       );
       ScaffoldMessenger.of(context).showSnackBar(snackbar);
     });

     if(currentAdmin !=null){

       await FirebaseFirestore.instance.collection("admin").doc(currentAdmin!.uid).get().then((snap){
         if(snap.exists){
           Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomePage()));
         }
       });

     }
     else{
       final snackbar=SnackBar(
         backgroundColor: pinkAccenColor,
         content: ReusableText(text: "No record found, You are not an admin",size: 36,color: blackColor,),
         duration:const Duration(seconds: 6),
       );
       ScaffoldMessenger.of(context).showSnackBar(snackbar);
     }

   }

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: width *.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/login_screen_image.png"),

                  TextField(
                    onChanged: (value){

                       email=value;

                    },
                    style:MyTextStyle.emailTextStyle,
                    decoration:const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(
                            color:amberColor,
                            width: 2
                          )
                        ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(
                              color:cyanColor,
                              width: 2
                          )
                      ),
                      hintText: "Email",
                      hintStyle: MyTextStyle.hintStyle,
                      icon: Icon(Icons.email,color: cyanColor,)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    onChanged: (value){

                      password=value;

                    },
                    obscureText: true,
                    style:MyTextStyle.emailTextStyle,
                    decoration:const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:BorderSide(
                                color:amberColor,
                                width: 2
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(
                                color:cyanColor,
                                width: 2
                            )
                        ),
                        hintText: "Password",
                        hintStyle: MyTextStyle.hintStyle,
                        icon: Icon(Icons.admin_panel_settings,color: cyanColor,)
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: (){
                        AllowAdminToLogin();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 90,vertical: 20)),
                        backgroundColor: MaterialStateProperty.all<Color>(amberColor),
                        foregroundColor: MaterialStateProperty.all<Color>(cyanColor),
                      ),
                      child: ReusableText(
                        text:"Login",size: 16,color: whiteColor,))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}



