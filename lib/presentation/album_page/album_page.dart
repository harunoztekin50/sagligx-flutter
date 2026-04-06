import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text("Album"))],
      ),
    );
  }
}
