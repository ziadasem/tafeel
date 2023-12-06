import 'dart:convert';
import 'dart:developer';

import 'package:tafeel/config/app_const.dart';
import 'package:http/http.dart' as http;
import 'package:tafeel/models/custom_error.dart';

class UsersServices {
  Future<Map> getUsers(int pageID) async{
    try{
      Uri uri = Uri.parse('${AppConst.baseUrl}users?page=$pageID');
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },  
      );
      Map result = jsonDecode(response.body) ??{};
      if (result.isEmpty){
        throw CustomError("حدث خطأ ما"); 
      }
      if (response.statusCode >= 300){
        throw CustomError("حدث خطأ ما حاول مرة أخرى في وقت آخر"); 
      }  
      return result ;  
    }catch(e){
      log(e.toString());
      rethrow ;
    }
  } 

  Future<Map> getSingleUser(String userId) async{
    try{
      Uri uri = Uri.parse('${AppConst.baseUrl}users/$userId');
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },  
      );
      Map result = jsonDecode(response.body) ??{};
      
      if (result.isEmpty){
        throw CustomError("حدث خطأ ما"); 
      }
      if (response.statusCode >= 300){
        throw CustomError("حدث خطأ ما حاول مرة أخرى في وقت آخر"); 
      }  
      return result ;  
    }catch(e){
      log(e.toString());
      rethrow ;
    }
  } 
}  

 