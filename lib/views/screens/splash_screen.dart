import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/config/app_const.dart';
import 'package:tafeel/utils/next_screen.dart';
import 'package:tafeel/views/screens/error_screen.dart';
import 'package:tafeel/views/screens/home_screen.dart';
import 'package:tafeel/vm/users_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  bool showLogo = false ;
  late Timer t ;

  @override
  void initState() {
    t = Timer.periodic(const Duration(milliseconds: 1200), (timer) { 
      setState(() {
        showLogo = !showLogo ;
      });
    });

    Future.delayed( Duration.zero).then((value) async{
      try{
        UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: false);
        await usersProvider.getUsers();      
        // ignore: use_build_context_synchronously
        nextScreenCloseOthers(context,  HomeScreen());
      }catch(e){
        // ignore: use_build_context_synchronously
        nextScreenCloseOthers(context, const  ErrorScreen());
      }
      
    });
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          alignment: Alignment.center,
          child: AnimatedOpacity(
            opacity: showLogo ? 1 : 0,
            duration: const Duration(milliseconds: 800),
            child: Image.asset(AppConst.logoPath,)),
        ),
    );
  }
}