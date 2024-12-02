import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/providers/user_provider.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';
import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> login() async{

    final String gmail = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (gmail.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Completa todos los campos')),
    );
    return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.authUser(gmail, password);
    final usuario = userProvider.currentUser;

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    } else {
    Navigator.popAndPushNamed(context, '/home');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.customSizeWidth(context, 0.1)),
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
                InputField(
                  controller: emailController,
                  hintText: 'Correo',
                  obscureText: false,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                InputField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.customSizeHeight(context, 0.02)),
                GeneralButton(
                  text: 'Iniciar sesión',
                  onPressed: login
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
                GeneralButton(
                  text: 'Registrarse',
                  isSecondary: true,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/register');
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
