import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tafeel/models/user.dart';
import 'package:tafeel/services/users_services.dart';
import 'package:tafeel/vm/users_provider.dart';

import 'uses_provider_test.mocks.dart';


@GenerateMocks([UsersServices])
Future<void> main() async {
  late MockUsersServices mockUsersServices = MockUsersServices();
   setUpAll(() {
    mockUsersServices = MockUsersServices();
  });
  UsersProvider usersProvider = UsersProvider(mockUsersServices);
   Map fakeUser = {
    "data": {
      "id": 2,
      "email": "janet.weaver@reqres.in",
      "first_name": "Janet",
      "last_name": "Weaver",
      "avatar": "https://reqres.in/img/faces/2-image.jpg",
    },
    "support": {
      "url": "https://reqres.in/#support-heading",
      "text": "To keep ReqRes free, contributions towards server costs are appreciated!",
    }
  };
  Map fakeResult = {
    "page": 1,
    "per_page": 6,
    "total": 12,
    "total_pages": 2,
    "data": [
      {
        "id": 1,
        "email": "george.bluth@reqres.in",
        "first_name": "George",
        "last_name": "Bluth",
        "avatar": "https://reqres.in/img/faces/1-image.jpg",
      },
      {
        "id": 2,
        "email": "janet.weaver@reqres.in",
        "first_name": "Janet",
        "last_name": "Weaver",
        "avatar": "https://reqres.in/img/faces/2-image.jpg",
      },
      {
        "id": 3,
        "email": "emma.wong@reqres.in",
        "first_name": "Emma",
        "last_name": "Wong",
        "avatar": "https://reqres.in/img/faces/3-image.jpg",
      },
      {
        "id": 4,
        "email": "eve.holt@reqres.in",
        "first_name": "Eve",
        "last_name": "Holt",
        "avatar": "https://reqres.in/img/faces/4-image.jpg",
      },
      {
        "id": 5,
        "email": "charles.morris@reqres.in",
        "first_name": "Charles",
        "last_name": "Morris",
        "avatar": "https://reqres.in/img/faces/5-image.jpg",
      },
      {
        "id": 6,
        "email": "tracey.ramos@reqres.in",
        "first_name": "Tracey",
        "last_name": "Ramos",
        "avatar": "https://reqres.in/img/faces/6-image.jpg",
      },
    ],
    "support": {
      "url": "https://reqres.in/#support-heading",
      "text": "To keep ReqRes free, contributions towards server costs are appreciated!",
    }
  };
  Map fakeResult2 = {
    "page": 11,
    "per_page": 6,
    "total": 12,
    "total_pages": 2,
    "data": [],
    "support": {
      "url": "https://reqres.in/#support-heading",
      "text": "To keep ReqRes free, contributions towards server costs are appreciated!",
    }
  };


  group("Testing getting users", () { 
    // Mocking results
    when(mockUsersServices.getUsers(1))
        .thenAnswer( (_) async => Future.value( fakeResult ));
    when(mockUsersServices.getUsers(2))
        .thenAnswer( (_) async => Future.value( fakeResult ));
    when(mockUsersServices.getUsers(3))
        .thenAnswer( (_) async => Future.value( fakeResult2 ));
    when(mockUsersServices.getUsers(4))
        .thenAnswer( (_) async => Future.value( fakeResult2 ));   
    when(mockUsersServices.getUsers(5))
        .thenAnswer( (_) async => Future.value( fakeResult2 ));

  when(mockUsersServices.getSingleUser("2"))
        .thenAnswer( (_) async => Future.value( fakeUser ));
  when(mockUsersServices.getSingleUser("ss"))
        .thenAnswer( (_) async => Future.value( {} ));
  when(mockUsersServices.getSingleUser("1000"))
        .thenAnswer( (_) async => Future.value( {} ));
  when(mockUsersServices.getSingleUser(null))
        .thenAnswer( (_) async => Future.value( {} ));
    test('test get users pagination goes beyond limit', () async {
     
        await usersProvider.getUsers();
        await usersProvider.getUsers();
        await usersProvider.getUsers();
        await usersProvider.getUsers();
        await usersProvider.getUsers();
        expect(usersProvider.lastPage, 3);     
    });

    test('test user searching', () async {   
        usersProvider.searchForUser("zzzzzzzzzzzzzzzzzzzzzz");
        expect(usersProvider.displayedUser.length, 0);   

        usersProvider.searchForUser("orge.bluth@");
        expect(usersProvider.displayedUser.length, 2);    

        usersProvider.searchForUser("rge");
        expect(usersProvider.displayedUser.length, 2);  

        usersProvider.searchForUser("uth");
        expect(usersProvider.displayedUser.length, 2); 

        usersProvider.searchForUser("");
        expect(usersProvider.displayedUser.length, 0);   
    });

     test('test getting user', () async {   
        await usersProvider.getSingleUser("2");
        expect(usersProvider.currentUser, isA<User>());  
    });
 
  });
}