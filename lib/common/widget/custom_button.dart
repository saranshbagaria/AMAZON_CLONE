import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color? color;
  final Color? textColor;
  const CustomButton(
      {Key? key,
      required this.onPress,
      required this.text,
      this.textColor = Colors.white,
      this.color = GlobalVariables.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          fixedSize: MaterialStateProperty.all(Size.infinite),
          padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
          minimumSize: MaterialStateProperty.all(
            const Size.fromHeight(50),
          ),
        ),
      ),
    );
  }
}
