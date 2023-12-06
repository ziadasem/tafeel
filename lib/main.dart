import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/config/app_const.dart';
import 'package:tafeel/services/users_services.dart';
import 'package:tafeel/views/screens/splash_screen.dart';
import 'package:tafeel/vm/users_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(
          create: (context) => UsersProvider(UsersServices()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConst.appName,
        theme: AppConst.theme(context),
        home: const SplashScreen(),
      ),
    );
  }
}