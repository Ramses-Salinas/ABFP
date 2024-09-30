import 'package:financial_app/presentation/themes/app_sizes.dart';
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        title: Center(child: Text('Ajustes', style: Theme.of(context).textTheme.displayLarge,)),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
                color: AppColors.lightPrimary,
                child: Column(
                  children: [
                    Center(
                        child: Text(
                            'Información Personal',
                            style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: AppSizes.customSizeHeight(context, 0.02),
                            )
                        )
                    ),
                    SizedBox(height:  AppSizes.customSizeHeight(context, 0.016)),
                    CircleAvatar(
                      radius:  AppSizes.customSizeHeight(context, 0.05),
                      backgroundColor: AppColors.textPrimary,
                      child: Icon(
                          Icons.person,
                          size:  AppSizes.customSizeHeight(context, 0.08),
                          color: AppColors.primary
                      ),
                    ),
                    SizedBox(height: AppSizes.smallSpace(context)),
                    Text('Adrián Quispe',
                      style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: AppSizes.customSizeHeight(context, 0.018)
                      )
                    ),
                    Text('adrianquispe@unmsm.edu.pe',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppSizes.customSizeHeight(context, 0.016)
                        )
                    ),
                    SizedBox(height:  AppSizes.customSizeHeight(context, 0.016)),
                    Text('Contraseña',
                        style: TextStyle(
                            color: AppColors.textBlack,
                            fontSize: AppSizes.customSizeHeight(context, 0.02)
                        )
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
                    Text('Nueva contraseña',
                        style: TextStyle(
                            color: AppColors.textBlack,
                            fontSize: AppSizes.customSizeHeight(context, 0.02)
                        )
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
              SizedBox(height: 16),
              Container(
                color: AppColors.lightPrimary,
                child: Column(
                  children: [
                    Text('Notificaciones', style: TextStyle(color: AppColors.textBlack, fontSize: 20)),
                    SwitchListTile(
                      title: Text('Notificaciones de correo', style: TextStyle(color: AppColors.textBlack,)),
                      value: true,
                      onChanged: (value) {},
                    ),
                    SwitchListTile(
                      title: Text('Alertas', style: TextStyle(color: AppColors.textBlack,)),
                      value: false,
                      onChanged: (value) {},
                    ),
                    SwitchListTile(
                      title: Text('Resumen semanal', style: TextStyle(color: AppColors.textBlack,)),
                      value: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: AppSizes.customSizeWidth(context, 1),
                  color: AppColors.lightPrimary,
                  child: Column(
                    children: [
                      Text('Gestión de datos', style: TextStyle(color: AppColors.textBlack, fontSize: 20)),
                      ElevatedButton(
                        onPressed: () {
                          // Handle data management
                        },
                        child: Text('Manejo de datos'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primary, backgroundColor: AppColors.lightPrimary,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle account deletion
                        },
                        child: Text('Borrar cuenta'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary, backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save changes
                  },
                  child: Text('Guardar cambios'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary, backgroundColor: AppColors.buttonPrimary,
                  ),
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
