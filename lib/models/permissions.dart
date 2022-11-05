library models;

import 'package:shoplogy/secrets/keys.dart';

abstract class Permission {
  static bool checkAdminKey(String key) {
    return AdminKeys.allKeys.contains(key);
  }
}
