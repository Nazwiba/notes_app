import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/googlesignin/screens/signin_screen.dart';
import 'package:notes_app/googlesignin/utils/authenitication.dart';
import 'package:notes_app/googlesignin/widgets/app_bar_titile.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            _user.photoURL != null
                ? ClipOval(
                    child: Material(
                      child: Image.network(
                        _user.photoURL!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 16,
            ),
            Text(
              "hello",
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _user.displayName!,
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "(${_user.email!})",
              style: TextStyle(fontSize: 20, letterSpacing: 0.5),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'You are now signed in using your Google account. To sign out of your accout click the "Sign Out" button below.',
              style: TextStyle(fontSize: 14, letterSpacing: 0.2),
            ),
            SizedBox(
              height: 16,
            ),
            _isSigningOut
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await Authentication.signOut(context: context);
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacement(_routeToSignInScreen());
                    },
                    child: Padding(padding: EdgeInsets.only(top: 8,bottom: 8),
                    child: Text("Sign Out",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 2,),),))
          ],
        ),
      )),
    );
  }
}
