import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:podpanda_web_ap_ui/authentication/login_screen.dart';
import 'package:podpanda_web_ap_ui/utils/all_text.dart';
import 'package:podpanda_web_ap_ui/utils/reusable_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String timeText = "";
  String dateText = "";

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = FormateCurrentLiveTime(timeNow);
    final String liveDate = FormateCurrentLiveDate(timeNow);

    if (this.mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  String FormateCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String FormateCurrentLiveDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  @override
  void initState() {
    timeText = FormateCurrentLiveTime(DateTime.now());
    dateText = FormateCurrentLiveDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.amber, Colors.cyan],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp),
          ),
        ),
        title: ReusableText(
            text: AllText.appBarText,
            size: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ReusableText(
                text: "$timeText\n$dateText",
                size: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ///Users active and block account ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                elevatedButton(text: "Activate Users" + "\n" + "Account", color: Colors.amber, icon: Icons.person_add, onTap: () {}),
                const SizedBox(
                  width: 20,
                ),
                elevatedButton(text: "Block Users" + "\n" + "Account", color: Colors.cyan, icon: Icons.block_outlined, onTap: () {}),

              ],
            ),
            ///Users active and block account ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                elevatedButton(text: "Activate sellers" + "\n" + "Account", color: Colors.cyan, icon: Icons.person_add, onTap: () {}),
                const SizedBox(
                  width: 20,
                ),
                elevatedButton(text: "Block sellers" + "\n" + "Account", color: Colors.amber, icon: Icons.block_outlined, onTap: () {}),

              ],
            ),
            ///Users active and block account ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                elevatedButton(text: "Activate riders" + "\n" + "Account", color: Colors.amber, icon: Icons.person_add, onTap: () {}),
                const SizedBox(
                  width: 20,
                ),
                elevatedButton(text: "Block riders" + "\n" + "Account", color: Colors.cyan, icon: Icons.block_outlined, onTap: () {}),

              ],
            ),
              ElevatedButton.icon(

                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                },
                icon:const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: ReusableText(
                  text:"LogOut",
                  size: 16,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(

                  padding: const EdgeInsets.all(40),
                  backgroundColor: Colors.amber,
                ),
              )

          ],
        ),
      ),
    );
  }

}

class elevatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const elevatedButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: ReusableText(
        text: text.toUpperCase(),
        size: 16,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(40),
        backgroundColor: color,
      ),
    );
  }
}
