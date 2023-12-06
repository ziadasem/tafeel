import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/config/app_const.dart';
import 'package:tafeel/utils/next_screen.dart';
import 'package:tafeel/views/screens/home_screen.dart';
import 'package:tafeel/vm/users_provider.dart';

// ignore: must_be_immutable
class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool isLoading = false ;
  late UsersProvider  usersProvider ;

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AppConst.logoPath), 
          const Text("an Error occurred", 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Cairo'
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text:  TextSpan(
                children: [
                   const TextSpan(
                      text: "there is an issue, please check your internet connection and refresh the application from here,",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20, 
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Cairo'
                      ),
                    ),
                    TextSpan(
                      text: "from here,",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20, 
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Cairo',
                      ),
                       recognizer: TapGestureRecognizer()..onTap = refreash
                    ), 
                    const TextSpan(
                      text: " if this issue continues please email us ",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20, 
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Cairo'
                      ),
                    ),
                    TextSpan(
                      text: "from here",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20, 
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Cairo'
                      ),
                    ),
                ]
              )
          ),
          const SizedBox(height: 10,),
          isLoading ?const CircularProgressIndicator() :Container()
          
        ]),
      ),
    );
  }

  void refreash () async{
    try{
      setState(() {
        isLoading = true ;
      });
      await usersProvider.getUsers(); 
      // ignore: use_build_context_synchronously
      nextScreenCloseOthers(context, HomeScreen());
    }catch(e){
      log(e.toString());
    }finally{
      setState(() {
        isLoading = false ;
      });
    }
  }
}