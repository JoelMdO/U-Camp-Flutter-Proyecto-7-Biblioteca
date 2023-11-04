import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  AppBarCustom({super.key})
      : super(
            title: const Text(''),
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/J code.png',
                width: 25,
                height: 25,
              ),
            ));
}
