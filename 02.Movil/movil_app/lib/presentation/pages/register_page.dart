import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/providers/user_provider.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';
import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController = TextEditingController();

  Future<void> register() async{

    final String name = nameController.text;
    final String gmail = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || gmail.isEmpty || password.isEmpty || confirmPassword.isEmpty)  {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      print("Datos enviados:");
      print("Nombre: $name");
      print("Email: $gmail");
      print("Password: $password");

      await userProvider.addUser(
        gmail: gmail,
        name: name,
        password: password,
      );
      print('Usuario registrado con éxito');
    } catch (e) {
      print('Error al registrar el usuario: $e');
    }

    Navigator.popAndPushNamed(context, '/home');
  }

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

                InputField(
                  controller: nameController,
                  hintText: 'Nombre completo',
                  obscureText: false,
                ),
                SizedBox(height: AppSizes.smallSpace(context)),
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
                InputField(
                  controller: confirmPasswordController,
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
                  onPressed: register
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
