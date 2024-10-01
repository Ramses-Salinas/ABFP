import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class GeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;

  const GeneralButton({super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSecondary ? AppColors.buttonSecondary : AppColors.buttonPrimary,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 18),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isSecondary ? AppColors.primary :  AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color color;

  const CustomButton({super.key, required this.onPressed, required this.icon, this.color = Colors.white, required this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: size,),
      onPressed: onPressed,
    );
  }
}