import 'package:flutter/material.dart';
import 'package:tafeel/models/user.dart';
import 'package:tafeel/services/users_services.dart';

class UsersProvider with ChangeNotifier {
  UsersServices usersServices ;
  UsersProvider(this.usersServices); //for seek of testing

  final List<User> _users = [] ;
  List<User> get users => _users ;

  List<User> _displayedUser = [] ;
  List<User> get displayedUser => _displayedUser ;
  void emptyDisplayedUSers() => _displayedUser = [] ;

  User? _currentUser ;
  User? get currentUser => _currentUser ;
  //set setCurrentUser(newVal) => _currentUser = newVal ;

  int _lastPage = 1 ;
  int get lastPage => _lastPage  ;

  String errorMsg = "" ;

  bool isLoading = false ;

  final Map _usersById = {};


  Future getUsers() async{
    try{
      setLoadingState(true);
     
      Map result = await  usersServices.getUsers(_lastPage);
      List tempUsers = result['data'];
      if ( tempUsers.isNotEmpty){
        _lastPage ++ ;
      }
     
      for (int i =0 ; i< tempUsers.length ; i ++){
        _users.add(User.fromJson(tempUsers[i]));
      }
      notifyListeners();
    }catch(e){
      rethrow;
    }finally{
      setLoadingState(false);
    }
  }

  Future getSingleUser(String userID) async{
    try{
      errorMsg = "";
      setLoadingState(true);
      if (_usersById[userID] != null){
        _currentUser =  _usersById[userID] ;
        setLoadingState(false);
        return ;
      }
      Map response = await  usersServices.getSingleUser(userID);
      _currentUser = User.fromJson(response['data']); 
      _usersById[userID] = _currentUser ;  
      setLoadingState(false);
    }catch(e){
      errorMsg = "an Error Occured";
      setLoadingState(false);
      rethrow;
    }
  }

  void searchForUser(String prfix){

    prfix = prfix.trim();
    if (prfix.isEmpty){
      _displayedUser= [];
      notifyListeners();
      return;
    }
    _displayedUser =  [... 
        _users.where((element) =>
           element.firstName.contains(prfix) ||
            element.lastName.contains(prfix) ||
            element.email.contains(prfix))
    ];
    notifyListeners();
  }

  void setLoadingState(bool state){
    isLoading = state;
    notifyListeners();
  }



}