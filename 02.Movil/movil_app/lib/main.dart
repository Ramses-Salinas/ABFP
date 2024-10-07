
import 'package:financial_app/presentation/pages/dashboard_page.dart';
import 'package:financial_app/presentation/pages/planificaction_page.dart';
import 'package:financial_app/presentation/pages/register_page.dart';
import 'package:financial_app/presentation/pages/settings_page.dart';
import 'package:financial_app/presentation/pages/transaction_add_page.dart';
import 'package:financial_app/presentation/pages/transaction_detail_page.dart';
import 'package:financial_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/providers/account_provider.dart';
import 'application/providers/category_provider.dart';
import 'application/providers/transaction_provider.dart';
import 'domain/Transaction/entities/transaction.dart';
import 'domain/user_management/entities/account.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';

void main() {
  Account account = Account();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
        ChangeNotifierProxyProvider<TransactionProvider, AccountProvider>(
          create: (_) => AccountProvider(account, Provider.of<TransactionProvider>(_, listen: false)),
          update: (context, transactionProvider, accountProvider) => accountProvider ?? AccountProvider(account, transactionProvider),
        ),
      ],
      child: const FinancialWellnessApp(),
    ),
  );
}

class FinancialWellnessApp extends StatelessWidget {
  const FinancialWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Wellness',
      theme: AppTheme.lightTheme(context),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (context) => const RegisterPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/transaction_add':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {return const TransactionAddPage();},
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/transaction_detail':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                final tx = settings.arguments as Transaction;
                return TransactionDetailPage(transaction: tx);
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/planning':
            return MaterialPageRoute(builder: (context) => const PlanningPage());
          case '/dashboard':
            return MaterialPageRoute(builder: (context) => DashboardPage());
          case '/settings':
            return MaterialPageRoute(builder: (context) => SettingsPage());
          default:
            return null;
        }
      },

    );
  }
}

