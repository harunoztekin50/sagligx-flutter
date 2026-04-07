import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: 'app_env/.env.prod', obfuscate: true)
abstract class EnvProd {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _EnvProd.apiBaseUrl;

  @EnviedField(varName: 'APP_ENV')
  static final String appEnv = _EnvProd.appEnv;
}
