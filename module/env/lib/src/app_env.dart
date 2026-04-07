import 'package:env/src/dev/env_dev.dart';
import 'package:env/src/prod/env_prod.dart';
import 'package:flutter/foundation.dart';

abstract class AppEnv {
  static String get apiBaseUrl => kReleaseMode ? EnvProd.apiBaseUrl : EnvDev.apiBaseUrl;

  static String get appEnv => kReleaseMode ? EnvProd.appEnv : EnvDev.appEnv;

  static bool get isDev => appEnv == 'dev';
  static bool get isProd => appEnv == 'prod';
}
