import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

Widget errorDialog(BuildContext context, String errorTitle, String errorCode) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(
        errorTitle,
        style: const TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(TextSpan(style: const TextStyle(fontSize: 16), children: [
            const TextSpan(
                text: 'Error Code: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: errorCode,
                style: const TextStyle(fontWeight: FontWeight.w400))
          ])),
        ],
      ),
      actions: [
        Center(
            child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                child: const Text('Try again')))
      ],
    );
  } else {
    return AlertDialog(
      elevation: 50,
      title: Text(
        errorTitle,
        style: const TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(TextSpan(style: const TextStyle(fontSize: 16), children: [
            const TextSpan(
                text: 'Error Code: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: errorCode,
                style: const TextStyle(fontWeight: FontWeight.w400))
          ])),
        ],
      ),
      actions: [
        Center(
            child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                child: const Text('Try again')))
      ],
    );
  }
}
