import 'package:amazon_clone/common/widget/custom_button.dart';
import 'package:amazon_clone/common/widget/custom_textField.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/authScreen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum Auth { signin, signup }

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _emailEditingController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  void signUpUser(){
    authService.signUpUser(
      context: context,
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
      name: _nameController.text);
  }

  void signInUser(){
    authService.signInUser(
      context: context, 
      email: _emailEditingController.text,
      password: _passwordEditingController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ), 
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text("Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                      value: Auth.signup,
                      activeColor: GlobalVariables.secondaryColor,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signup)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signUpFormKey,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _nameController, hintText: "Name"),
                              CustomTextField(
                                  controller: _emailEditingController,
                                  hintText: "Email"),
                              CustomTextField(
                                  controller: _passwordEditingController,
                                  hintText: "Password"),
                              CustomButton(
                                onPress: () {
                                  if(_signUpFormKey.currentState!.validate()){
                                     signUpUser();
                                  }
                                 
                                },
                                text: 'Sign Up',
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                      value: Auth.signin,
                      activeColor: GlobalVariables.secondaryColor,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signin)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signInFormKey,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _emailEditingController,
                                  hintText: "Email"),
                              CustomTextField(
                                  controller: _passwordEditingController,
                                  hintText: "Password"),
                              CustomButton(
                                onPress: () {
                                  if(_signInFormKey.currentState!.validate()){
                                    signInUser();
                                  }
                                },
                                text: 'Sign In',
                              )
                            ],
                          ),
                        )),
                  ),
              ],
            )
        )
    );
  }
}
