import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? btnWidth;
  final double? btnHeight;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final Color btnColor;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    required this.btnTextColor,
    //this.btnTextColor = AppColors.whitecolor,
    this.fontSize = 14,
    this.btnWidth,
    this.btnHeight,
    required this.btnColor,
    // this.btnColor = AppColors.primaryColor,
  });

  get urbanistBold => null;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(
            btnWidth ?? MediaQuery.of(context).size.width,
            btnHeight ?? MediaQuery.of(context).size.height * 0.06,
          ),
          backgroundColor: btnColor,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      child: Center(
        child: Text(
          btnText,
          style: urbanistBold.copyWith(
            fontSize: fontSize,
            color: btnTextColor,
          ),
        ),
      ),
    );
  }
}
