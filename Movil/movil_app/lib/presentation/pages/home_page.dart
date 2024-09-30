import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';
import '../widgets/transaction_list.dart';
import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';

class HomePage extends StatefulWidget { // Cambiar a StatefulWidget
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola",
                    style: TextStyle(fontSize: AppSizes.mediumSpace(context), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: AppSizes.customSizeHeight(context, 0.001)),
                  Text(
                    "Adrián Quispe",
                    style: TextStyle(fontSize: AppSizes.mediumSpace(context), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: AppSizes.mediumSpace(context)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.customSizeHeight(context, 0.005), horizontal: AppSizes.customSizeWidth(context, 0.04)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dinero total",
                              style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
                            ),
                            SizedBox(height: AppSizes.customSizeHeight(context, 0.005)),
                            const Text(
                              "S/385.00",
                              style: TextStyle(color: AppColors.textPrimary, fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: AppSizes.customSizeWidth(context, 0.36)),
                        CustomButton(
                          icon: Icons.add_circle,
                          size: AppSizes.customSizeWidth(context, 0.1),
                          onPressed: () {
                            Navigator.pushNamed(context, '/transaction_add');
                          },
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.customSizeHeight(context, 0.004)),
            SizedBox(
              height: AppSizes.customSizeHeight(context, 0.05),
              child: const SearchField(
                hintText: "Buscar transacciones",
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: TransactionList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
