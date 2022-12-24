import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  // ScaffoldMessenger(
  //   key: scaffoldMessengerKey,
  //   child: SnackBar(content: Text(text)),
  // );

  scaffoldMessengerKey.currentState
      ?.showSnackBar(SnackBar(content: Text(text)));

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
