import 'package:financial_app/presentation/themes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/providers/user_provider.dart';
import '../themes/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 3;

  bool _emailNotifications = true;
  bool _alerts = false;
  bool _weeklySummary = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Ajustes',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.smallWidthSpace(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.mediumWidthSpace(context)),
                color: AppColors.lightPrimary,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Información Personal',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: AppSizes.customSizeHeight(context, 0.02),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.mediumSpace(context)),
                    CircleAvatar(
                      radius: AppSizes.customSizeHeight(context, 0.05),
                      backgroundColor: AppColors.textPrimary,
                      child: Icon(
                        Icons.person,
                        size: AppSizes.customSizeHeight(context, 0.08),
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: AppSizes.smallSpace(context)),
                    Text(
                      userProvider.currentUser!.nombre,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: AppSizes.customSizeHeight(context, 0.018),
                      ),
                    ),
                    Text(
                      userProvider.currentUser!.gmail,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppSizes.customSizeHeight(context, 0.016),
                      ),
                    ),
                    SizedBox(height: AppSizes.mediumSpace(context)),
                    Text(
                      'Contraseña',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: AppSizes.customSizeHeight(context, 0.02),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.customSizeHeight(context, 0.05),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.smallSpace(context)),
                    Text(
                      'Nueva contraseña',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: AppSizes.customSizeHeight(context, 0.02),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.customSizeHeight(context, 0.05),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: AppColors.lightPrimary,
                child: Column(
                  children: [
                    const Text(
                      'Notificaciones',
                      style: TextStyle(color: AppColors.textBlack, fontSize: 20),
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Notificaciones de correo',
                        style: TextStyle(color: AppColors.textBlack),
                      ),
                      value: _emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Alertas',
                        style: TextStyle(color: AppColors.textBlack),
                      ),
                      value: _alerts,
                      onChanged: (value) {
                        setState(() {
                          _alerts = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Resumen semanal',
                        style: TextStyle(color: AppColors.textBlack),
                      ),
                      value: _weeklySummary,
                      onChanged: (value) {
                        setState(() {
                          _weeklySummary = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: AppSizes.screenWidth(context),
                  color: AppColors.lightPrimary,
                  child: Column(
                    children: [
                      const Text(
                        'Gestión de datos',
                        style: TextStyle(color: AppColors.textBlack, fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle data management
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          backgroundColor: AppColors.lightPrimary,
                        ),
                        child: const Text('Manejo de datos'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle account deletion
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Borrar cuenta'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save changes
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    backgroundColor: AppColors.buttonPrimary,
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
