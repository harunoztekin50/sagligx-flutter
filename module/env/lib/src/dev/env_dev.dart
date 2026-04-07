import 'package:envied/envied.dart';

part 'env_dev.g.dart';

@Envied(path: 'app_env/.env.dev', obfuscate: true)
abstract class EnvDev {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _EnvDev.apiBaseUrl;

  @EnviedField(varName: 'APP_ENV')
  static final String appEnv = _EnvDev.appEnv;
}
