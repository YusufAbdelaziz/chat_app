import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
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
    saveUserData();
  }

  Future<void> updateFacebookUserInfo(
      {@required Map<String, dynamic> profileData, @required FirebaseUser firebaseUser}) async {
    _user.name = profileData['name'];
    _user.email = profileData['email'];
    _user.imageUrl = profileData['picture']['data']['url'];
    _user.isVerified = true;
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  Future<void> updateSignInUserInfo({@required FirebaseUser firebaseUser}) async {
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  Future<void> updateSignUpUserInfo(
      {@required FirebaseUser firebaseUser, @required String name}) async {
    _user.name = name;
    _user.email = firebaseUser.email;
    print('sign up ! $name');
    print('sign up ! ${firebaseUser.email}');
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  Future<void> updateGoogleUserInfo(
      {@required GoogleSignInAccount googleAccount, @required FirebaseUser firebaseUser}) async {
    _user.name = googleAccount.displayName;
    _user.email = googleAccount.email;
    _user.imageUrl = googleAccount.photoUrl;
    _user.isVerified = true;
    await _updateUserInfo(firebaseUser: firebaseUser);
  }

  void saveUserData() {
    var userBox = Hive.box(userBoxName);
    userBox.put(0, _user.toJson());
  }

  Future<void> fetchUserData() async {
    var userBox = await Hive.openBox(userBoxName);
    if (userBox.isNotEmpty) {
      print('we got dataaaa');
      _user.changeSingletonFromJson(userBox.getAt(0));
    } else {
      print('box is empty');
    }
  }

  /// Deletes the user info from the app and setting the token to null to return back to auth screen.
  Future<void> clearUserData() async {
    await Hive.deleteBoxFromDisk(userBoxName);
    _user.token = null;
    _user.isVerified = false;
  }

  bool isUserValid() {
    return _user.token != null && _user.tokenExpiryDate.isAfter(DateTime.now());
  }

  void verifyEmail() {
    _user.isVerified = true;
    saveUserData();
  }

  bool isUserEmailVerified() {
    return _user.isVerified;
  }

  Map<String, dynamic> getFirestoreUserData() {
    return {
      'name': _user.name,
      'imageUrl': _user.imageUrl,
      'userEmail': _user.email,
      'id': _user.id
    };
  }

  static UserRepository _userRepository;
  UserRepository._();
  static UserRepository getInstance() {
    if (_userRepository == null) {
      _userRepository = UserRepository._();
    }
    return _userRepository;
  }
}
