import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) {
        return LoginPage._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                //context.read<AuthCubit>().loginAnonymus();
              },
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
