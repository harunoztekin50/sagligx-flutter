import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/application/botom_nav_bar/botom_nav_bar_cubit.dart';
import 'package:saglixen/core/http_wrap/client_with_timeout.dart';
import 'package:saglixen/infrastructure/auth/auth_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final getit = GetIt.instance;

Future<void> setupInjection() async {
  // lazy — hemen üretme, ilk kullanımda üret
  getit.registerLazySingleton<Client>(() => TimeoutClient());
  getit.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getit.registerLazySingleton<Uuid>(() => const Uuid());

  // async singleton — SharedPreferences await gerektiriyor
  getit.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  // infra — lazy, bağımlıları zaten lazy kayıtlı
  getit.registerLazySingleton<AuthClient>(
    () => AuthClient(
      client: getit<Client>(),
      secureStroage: getit<FlutterSecureStorage>(),
      uuid: getit<Uuid>(),
    ),
  );

  // factory — her seferinde yeni instance
  getit.registerFactory<AuthCubit>(
    () => AuthCubit(getit<AuthClient>()),
  );

  getit.registerFactory<BotomNavBarCubit>(() => BotomNavBarCubit());
  await getit.allReady();
}
