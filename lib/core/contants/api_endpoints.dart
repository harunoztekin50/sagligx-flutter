import 'package:env/env.dart';

abstract class ApiEndpoints {
  static String get _base => AppEnv.apiBaseUrl;

  static Uri get anonymousLogin =>
      Uri.parse("$_base/auth/login/anonymus");
  static Uri get user => Uri.parse("$_base/auth/user");
  static Uri get logout => Uri.parse("$_base/auth/logout");
  static Uri get refresh => Uri.parse("$_base/auth/refresh");
  static const Duration timeout = Duration(seconds: 5);
}
