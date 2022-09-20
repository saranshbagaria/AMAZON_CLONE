import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
  }
){
  ScaffoldMessenger
  .of(context)
  .showSnackBar(
    SnackBar(content: Text(text)
    )
  );
  
}