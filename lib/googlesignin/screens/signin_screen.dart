import 'package:flutter/material.dart';
import 'package:notes_app/googlesignin/utils/authenitication.dart';
import 'package:notes_app/googlesignin/widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/firebase_logo.png",
                      height: 160,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Flutterfire",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  "Authentication",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            )),
            FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error initializing Firebase");
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator();
                }))
          ],
        ),
      )),
    );
  }
}
