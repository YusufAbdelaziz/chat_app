import 'dart:convert';

/// A Singleton class which is accessible globally so you can modify freely.
class User {
  String token;
  String id;
  String name;
  String imageUrl;
  String email;
  DateTime tokenExpiryDate;
  bool isVerified = false;
  bool isDarkMode;

  static User _user;
  User._();

  static User getInstance() {
    if (_user == null) {
      _user = User._();
    }
    return _user;
  }

  String toJson() {
    return json.encode({
      'token': _user.token,
      'id': _user.id,
      'name': _user.name,
      'imageUrl': _user.imageUrl,
      'email': _user.email,
      'isVerified': _user.isVerified,
      'themeMode': _user.isDarkMode,
      'tokenExpiryDate': _user.tokenExpiryDate?.toIso8601String()
    });
  }

  void changeUserFromJson(String userJson) {
    final jsonMap = json.decode(userJson) as Map<String, dynamic>;
    _user.isDarkMode = jsonMap['themeMode'];
    _user.token = jsonMap['token'];
    _user.id = jsonMap['id'];
    _user.name = jsonMap['name'];
    _user.email = jsonMap['email'];
    _user.isVerified = jsonMap['isVerified'];
    _user.imageUrl = jsonMap['imageUrl'];
    _user.tokenExpiryDate = DateTime.parse(jsonMap['tokenExpiryDate']);
    print('isDarkMode : ' + _user.isDarkMode.toString());
    print('token : ' + _user.token.substring(0,8));
    print('id : ' + _user.id);
    print('name :' + _user.name);
    print('email : ' + _user.email);
    print('isEmailVerified : ' + _user.isVerified.toString()?? null);
    print('expiryDate : ' + _user.tokenExpiryDate.toIso8601String());
  }
}
