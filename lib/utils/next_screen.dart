
import 'package:flutter/material.dart';

void nextScreen (context, page, {arguments}){
  if (page.runtimeType.toString() == "String"){
     Navigator.pushNamed(context,page, arguments: arguments);
    return ;
  }
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => page));
}

void nextScreenCloseOthers (context, page, {arguments}){
  if (page.runtimeType.toString() == "String"){
    Navigator.pushNamedAndRemoveUntil(context, page, (route) => false, arguments: arguments);
    return ;
  }
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace (context, page, {arguments}){
  if (page.runtimeType.toString() == "String"){
      Navigator.pushReplacementNamed(context, page, arguments: arguments);
      return;
  }
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}