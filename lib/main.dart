import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/infrastructure/auth/auth_client.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final authCubit = AuthCubit(
    AuthClient(
      client: Client(),
      secureStroage: FlutterSecureStorage(),
      uuid: Uuid(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<AuthCubit, AuthCubitState>(
          bloc: authCubit,
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    state.userOption.fold(
                      () {
                        return "kulanıcı yok";
                      },
                      (user) {
                        return "kulanıcı var ${user.name}  user id: ${user.id}";
                      },
                    ),
                    style: TextStyle(fontSize: 25),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await authCubit.loginAnonymus();
                    },
                    child: state.isSingingIn
                        ? CupertinoActivityIndicator()
                        : Text("Login Anonymus"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
