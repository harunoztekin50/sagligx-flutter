import 'package:flutter/material.dart';
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello World!'),
              ElevatedButton(
                onPressed: () async {
                  await authCubit.loginAnonymus();
                },
                child: Text("Login Anonymus"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
