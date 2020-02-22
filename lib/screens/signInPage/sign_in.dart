import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../signInPage/widgets/google_sign_in_button.dart';


class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _handleSignIn() async {
    // Check if user isn't already logged in
    FirebaseUser fbUser = await FirebaseAuth.instance.currentUser();
    if (fbUser != null) {
      print("Already logged in.");
    } else {
      // Request google account.
      GoogleSignInAccount googleUser = await googleSignIn.signIn().catchError((err) => print(err.toString()));

      GoogleSignInAuthentication googleAuth = await googleUser.authentication.catchError((err) => print(err.toString()));

      // Get authentication credentials.
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in
      final AuthResult signInResult = await _auth.signInWithCredential(credential).catchError((err) => print(err.toString()));
      fbUser = signInResult.user;
    }

    print("Signed in as " + fbUser.displayName);
    // Navigate to home.
    Navigator.pushReplacementNamed(context, '/signin');
  }

 /*Future<FirebaseUser> _handleSignOut() async {
   googleSignIn.signOut();
   _auth.signOut();
   print("current user" + FirebaseAuth.instance.currentUser().toString()); 
   return null;
 }*/

 

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,      
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png"), height: 320.0),
              SignInButton(
                onPressed: _handleSignIn,
              ),
              //_signOutButton(),
              
            ],
          ),
        ),
        
      ),
      
    );
  }

 /* Widget _signOutButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () { _handleSignOut().then(
        (FirebaseUser user)=>print(user),        
      );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  */





}
