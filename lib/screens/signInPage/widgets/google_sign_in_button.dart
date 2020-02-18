import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  SignInButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:
          ShapeDecoration(
            shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
            ), 
            color: Colors.white),
      child: Theme(
        data: Theme.of(context).copyWith(
            buttonTheme: ButtonTheme.of(context).copyWith(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        child: OutlineButton(
          splashColor: Colors.grey,
          color: Colors.white,
          onPressed: this.onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/google_logo.png"), height: 24.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}