import 'package:flutter/material.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';
import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSizes.largeSpace(context)),
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.nights_stay, size: AppSizes.customSizeHeight(context, 0.09), color: AppColors.primary),
                      SizedBox(height: AppSizes.smallSpace(context)),
                      Text(
                        'Financial Wellness',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.largeSpace(context)),
                const InputField(
                  hintText: 'Nombre completo',
                  obscureText: false,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                const InputField(
                  hintText: 'Correo',
                  obscureText: false,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                const InputField(
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                const InputField(
                  hintText: 'Confirmar contraseña',
                  obscureText: true,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.customSizeHeight(context, 0.02)),
                GeneralButton(
                  text: 'Registrarse',
                  onPressed: () {
                    // Handle login logic here
                  },
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                GeneralButton(
                  text: 'Iniciar sesión',
                  isSecondary: true,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
