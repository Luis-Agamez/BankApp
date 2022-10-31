import 'package:flutter/material.dart';
import '../screens/data_transfer/screens.dart';
import '../screens/loading_screen.dart';
import '../screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'validate': (_) => const ValidateScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'saving': (_) => const AccountSavingScreen(),
  'data': (_) => const DataTransferScreen(),
  'check': (_) => const CheckScreen(),
  'loading': (_) => const LoadingScreen(),
};
