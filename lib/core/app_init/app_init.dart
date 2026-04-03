// core/startup/app_init.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/core/dependy_injekt.dart/dependy.dart';

@immutable
final class AppInit {
  const AppInit._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupInjection();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    FlutterError.onError = (details) {
      debugPrint(details.exceptionAsString());
    };
  }

  static Widget providers({required Widget child}) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getit<AuthCubit>())],
      child: child,
    );
  }
}
