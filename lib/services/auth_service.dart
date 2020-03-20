import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Used to authenticate users.
/// 
/// This service is used through a singleton, which is accessible on the [AuthService.instance] property.
class AuthService {
  // ------------------------------------------------
  //               Private properties
  // ------------------------------------------------
  // Get auth provider instances.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  // ------------------------------------------------
  //               Public properties
  // ------------------------------------------------
  /// The currently logged in user.
  /// Is null when the user isn't logged in.
  FirebaseUser currentUser;

  /// Checks if there is any signed in user.
  Future<bool> isUserSignedIn() async {
    FirebaseUser user = await _auth.currentUser();
    return user != null;
  }

  // ------------------------------------------------
  //                Public methods
  // ------------------------------------------------
  /// Sign in to firebase using Google authentication.
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser;
    if (currentUser == null) {
      try {
        googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          // User canceled the sign-in.
          return null;
        }
        // Get authentication credentials.
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        );
        // Sign in.
        AuthResult signInResult = await _auth.signInWithCredential(credential); 
        currentUser = signInResult.user;
      } catch (e) {
        currentUser = null;

        switch (e.code) {
          case 'ERROR_USER_DISABLED':
            print('Google Sign-In error: User disabled');
            break;
          case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
            print('Google Sign-In error: Account already exists with a different credential.');
            break;
          case 'ERROR_INVALID_CREDENTIAL':
            print('Google Sign-In error: Invalid credential.');
            break;
          case 'ERROR_OPERATION_NOT_ALLOWED':
            print('Google Sign-In error: Operation not allowed.');
            break;        
          default:
            print('Google Sign-In error');
            print(e);
            break;
        }
      }
    }

    if (currentUser != null) {
      print("Signed in as: " + currentUser.displayName);
    } else {
      print("You are not signed in.");
    }

    return currentUser;
  }

  /// Sign the current user out.
  void signOut() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
    }
    if (currentUser != null) {
      _auth.signOut();
    }
    currentUser = null;
    print("User signed out.");
  }
}