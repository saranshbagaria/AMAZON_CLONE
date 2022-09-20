
import 'dart:convert';

import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/error_hadlig.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/Screens/home_screen.dart';
import 'package:amazon_clone/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
class AuthService{
    //sign up user
    void signUpUser({
        required BuildContext context,
        required String email,
        required String password,
        required String name,
    }) async {
        try{
          User user = User(
            id: '', 
            name: name,
            email: email,
            password: password, 
            address: '', 
            type: '',
            token: ''
            );

            http.Response res = await http.post(Uri.parse('$uri/api/signup'), 
              body : user.toJson(),
              headers: <String,String>{
                'Content-Type':'application/json; charset=UTF-8'
              }
            );
            
            loginErrorHandling(
              response: res, 
              context: context, 
              onSuccess: ()=>{
                  showSnackbar(
                    context: context, 
                    text: 'Account has been created success fully')
              }
            );
              
        }catch(e){
          showSnackbar(context: context,
           text: e.toString());
        }
    }

   void signInUser({
      required BuildContext context,
      required String email,
      required String password, 
    }) async {
      try{
          
            http.Response res = await http.post(Uri.parse('$uri/api/signin'), 
              body : jsonEncode({
                'email' : email,
                'password': password
              }),  
              headers: <String,String>{
                'Content-Type':'application/json; charset=UTF-8'
              }
            );
            
            loginErrorHandling(
              response: res, 
              context: context, 
              onSuccess: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                Provider.of<UserProvider>(context,listen: false).setUser(res.body);
                await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                   (route) => false);
              }
            );
              
        }catch(e){
          showSnackbar(context: context,
           text: e.toString());
        }
  

    }

}