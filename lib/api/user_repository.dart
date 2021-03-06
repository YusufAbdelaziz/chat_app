import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';

/// A Singleton class that is capable of changing the user data.
class UserRepository {
  final userBoxName = 'user';
  User _user = User.getInstance();

  /// Saves the commonalities of user model fields in the sign in methods.
  Future<void> _updateUserInfo({@required FirebaseUser firebaseUser}) async {
    final tokenResult = await firebaseUser.getIdToken();
    _user.token = tokenResult.token;
    _user.tokenExpiryDate = tokenResult.expirationTime;
    _user.id = firebaseUser.uid;
    await saveUserData();
  }

  /// Updates the user model with what you get from facebook account like email, display name,
  /// and photo url.
  Future<void> updateFacebookUserInfo(
      {@required Map<String, dynamic> profileData, @required FirebaseUser firebaseUser}) async {
    _user.name = profileData['name'];
    _user.email = profileData['email'];
    _user.imageUrl = profileData['picture']['data']['url'];
    _user.isVerified = true;
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  /// Updating the user model when user signs in.
  Future<void> updateSignInUserInfo({@required FirebaseUser firebaseUser}) async {
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  /// Updating the user model when user signs up.
  Future<void> updateSignUpUserInfo(
      {@required FirebaseUser firebaseUser, @required String name}) async {
    _user.name = name;
    _user.email = firebaseUser.email;
    print('sign up ! $name');
    print('sign up ! ${firebaseUser.email}');
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  /// Updates the user model with what you get from google account like email, display name, and photo url.
  Future<void> updateGoogleUserInfo(
      {@required GoogleSignInAccount googleAccount, @required FirebaseUser firebaseUser}) async {
    _user.name = googleAccount.displayName;
    _user.email = googleAccount.email;
    _user.imageUrl = googleAccount.photoUrl;
    _user.isVerified = true;
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  /// Saves user data using Hive.
  Future<void> saveUserData() async {
    /// Declare the userBox variable then check if there's a box has been opened or not, so you cover the
    /// scenario in which the user may log in so his data is saved and then he logged out so his data is
    /// removed therefore the box is removed and lastly the user logged in again so you have to re-
    /// create the box once again.
    Box<dynamic> userBox;
    if (!Hive.isBoxOpen(userBoxName)) {
      userBox = await Hive.openBox(userBoxName);
    }
    userBox = Hive.box(userBoxName);
    userBox.put(0, _user.toJson());
  }

  /// Fetches data from Hive.
  Future<void> fetchUserData() async {
    var userBox = await Hive.openBox(userBoxName);
    if (userBox.isNotEmpty ) {
      print('we got dataaaa');
      print('userBox --> ${userBox.getAt(0)}');
      _user.changeUserFromJson(userBox.getAt(0));
    } else {
      print('box is empty');
    }
  }

  /// Deletes the user info from the app and sets the token to null to return back to auth screen.
  Future<void> clearUserData() async {
    await Hive.deleteBoxFromDisk(userBoxName);
    _user.token = null;
    _user.isVerified = false;
  }

  /// Checks the if the token is not null and the token is not expired.
  bool isUserValid() {
    return _user.token != null && _user.tokenExpiryDate.isAfter(DateTime.now());
  }

  /// Verifying the user at runtime and saves the verification state using Hive.
  Future<void> verifyEmail() async {
    _user.isVerified = true;
    await saveUserData();
  }

  /// Checks of the user is authenticated or not.
  bool isUserEmailVerified() {
    return _user.isVerified;
  }

  /// Gets map of user information to store it in firestore database.
  Map<String, dynamic> getFirestoreUserData() {
    return {
      'name': _user.name,
      'imageUrl': _user.imageUrl,
      'userEmail': _user.email,
      'id': _user.id
    };
  }

  /// Sets the new theme that user chooses.
  Future<void> setUserTheme({@required isDarkMode}) async {
    _user.isDarkMode = isDarkMode;
    await saveUserData();
  }

  Future<void> updateUserToken({@required String token, @required DateTime expiryTime}) async{
    _user.token = token;
    _user.tokenExpiryDate = expiryTime;
    await saveUserData();
  }

  bool get isDarkMode => _user.isDarkMode;

  String get userId => _user.id;

  String get userEmail => _user.email;
  static UserRepository _userRepository;
  UserRepository._();
  static UserRepository getInstance() {
    if (_userRepository == null) {
      _userRepository = UserRepository._();
    }
    return _userRepository;
  }
}
