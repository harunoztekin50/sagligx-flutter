import 'package:flutter/material.dart';
import 'package:saglixen/core/contants/string_constansts.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(StringConstants.album),
          ),
        ],
      ),
    );
  }
}
