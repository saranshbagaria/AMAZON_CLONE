import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './utils.dart';

void loginErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess}
){
  switch(response.statusCode){
    case 200 : 
      onSuccess();
      break;
    case 400 :
      showSnackbar(
        context : context, 
        text : jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(
        context: context, 
        text: jsonDecode(response.body)['error']);
      break;
    default: 
      showSnackbar(
        context : context,
        text: response.body
      );
  }

  
}