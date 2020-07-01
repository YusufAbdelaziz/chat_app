import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'user_repository.dart';
import 'package:chatapp/api/firestore_repository.dart';

class AuthRepository {
  final _firebaseAuthInstance = FirebaseAuth.instance;
  final _facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();
  final _userRepo = UserRepository.getInstance();
  final _firestoreRepo = FirestoreRepository.getInstance();
  AuthResult _authResult;
  FirebaseUser _firebaseUser;

  /// Signs user in with facebook and authenticate it using [FirebaseAuth].
  Future<void> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await _facebookLogin.logIn(['email']);
    print(result.accessToken.expires);
    final status = result.status;
    if (status == FacebookLoginStatus.loggedIn) {
      final credentials = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      _authResult = await _firebaseAuthInstance.signInWithCredential(credentials);
      _firebaseUser = _authResult.user;
      final token = result.accessToken.token;
      await _getFacebookUserInfo(token: token, firebaseUser: _firebaseUser);
    } else if (status == FacebookLoginStatus.cancelledByUser) {
      throw Exception('Cancelled');
    } else if (status == FacebookLoginStatus.error) {
      throw Exception('Something went wrong');
    }
  }

  /// Making a request to fetch the user name, email and picture.
  Future<void> _getFacebookUserInfo(
      {@required String token, @required FirebaseUser firebaseUser}) async {
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token');
    final profileData = json.decode(graphResponse.body);
    await _userRepo.updateFacebookUserInfo(profileData: profileData, firebaseUser: firebaseUser);
  }

  /// Signs user in with google and authenticate it using [FirebaseAuth].
  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credentials = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    _authResult = await _firebaseAuthInstance.signInWithCredential(credentials);
    _firebaseUser = _authResult.user;
    await _userRepo.updateGoogleUserInfo(googleAccount: googleUser, firebaseUser: _firebaseUser);
  }

  /// Signs the user in with email, password using [FirebaseAuth].
  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    _authResult =
        await _firebaseAuthInstance.signInWithEmailAndPassword(email: email, password: password);
    _firebaseUser = _authResult.user;
    print(_authResult.user.email);
    print(_authResult.user.displayName);
    await _userRepo.updateSignInUserInfo(firebaseUser: _firebaseUser);
  }

  /// Signs the user up with email, password and user name using [FirebaseAuth] and sending email verification.
  Future<void> signUpWithEmailAndPassword(
      {@required String email, @required String password, @required String userName}) async {
    _authResult = await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = _authResult.user;
    await sendEmailVerification();
    await _userRepo.updateSignUpUserInfo(firebaseUser: _firebaseUser, name: userName);
  }

  /// Logs the user out using firebase auth instance, googleSignIn instance and facebookLogin instance
  /// as well as clearing his data that was stored in Hive.
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _facebookLogin.logOut();
    await _firebaseAuthInstance.signOut();
    await _userRepo.clearUserData();
  }

  /// Checks if the user is authenticated after getting the proper reference object of firebase auth
  /// instance.
  Future<bool> isUserAuthenticated() async {
    /// We are refreshing the firebase object even after the app is closed.
    _firebaseUser = await _firebaseAuthInstance.currentUser();
    return _userRepo.isUserValid();
  }

  /// Adds the user to firestore database.
  Future<void> addUserToFirestore() async {
    await _firestoreRepo.addFirestoreUser(userData: _userRepo.getFirestoreUserData());
  }

  Future<bool> isEmailVerified() async {
    /// Getting current user is required so you can get the proper firebaseAuth instance to verify
    /// the email even after the app is closed.
    _firebaseUser = await _firebaseAuthInstance.currentUser()
      ..reload();
    print('is verified ? ' + _firebaseUser.isEmailVerified.toString());
    print('email ' + _firebaseUser.email);
    if (_firebaseUser.isEmailVerified) {
      await _userRepo.verifyEmail();
      return true;
    }
    return false;
  }

  bool isUserEmailVerified() {
    return _userRepo.isUserEmailVerified();
  }

  Future<void> sendEmailVerification() async {
    await _firebaseUser.sendEmailVerification();
  }

  Stream<FirebaseUser> onAuthStateChanged() {
    return _firebaseAuthInstance.onAuthStateChanged;
  }

  Future<void> updateUserToken({@required String token, @required DateTime expiryDate}) async {
    await _userRepo.updateUserToken(token: token, expiryTime: expiryDate);
  }

  /// This is used to return a proper text rather than scream caps warnings that [FirebaseAuth] returns.
  String showErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'ERROR_INVALID_EMAIL':
        return "The email address is badly formatted.";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'ERROR_WRONG_PASSWORD':
        return "E-mail address or password is incorrect.";

      default:
        return "An error has occurred";
    }
  }
}
