library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:shoplogy/models/permissions.dart';
import 'package:shoplogy/models/users.dart';
import 'package:shoplogy/storage/storage.dart';

class UserBloc extends Bloc {
  bool processinglogging = false;
  String name = '';
  String lastname = '';
  String adminKey = '';

  /// A Method to
  /// log in and create a new User.
  bool logIn() {
    processinglogging = true;
    final User user;
    if (adminKey.isNotEmpty) {
      if (Permission.checkAdminKey(adminKey)) {
        user = User.admin(
          name: name,
          lastname: lastname,
        );
      } else {
        return false;
      }
    } else {
      user = User(
        name: name,
        lastname: lastname,
      );
    }
    User.changeUser(user);
    Storage.store();
    processinglogging = false;
    return true;
  }

  bool logOut() {
    processinglogging = true;
    User.logOut();
    Storage.store();
    processinglogging = false;
    return true;
  }

  /// Checks if all required fields
  /// are entered and if the User
  /// is ready to log in
  bool readyToLogIn() {
    return name.isNotEmpty && lastname.isNotEmpty;
  }

  @override
  void dispose() {}
}
