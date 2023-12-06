import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/vm/users_provider.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    final double w = MediaQuery.of(context).size.width ;
    List<Map> items = [
      {
      "icon": FontAwesomeIcons.envelope,
      "title": "Email", 
      "value": usersProvider.currentUser?.email ??"N/A",
      },
       {
      "icon": FontAwesomeIcons.facebook,
      "title": "Facebook", 
      "value": "fb.com/loremipsum",
      },
      {
      "icon": FontAwesomeIcons.twitter,
      "title": "X", 
      "value": "x.com/loremipsum",
      },
      {
      "icon": FontAwesomeIcons.instagram,
      "title": "Instagram", 
      "value": "instagram.com/loremipsum",
      },
    ];
    return Scaffold(
      body: usersProvider.isLoading ?const Center(child: CircularProgressIndicator(),)
      : usersProvider.errorMsg.isNotEmpty ?
        ErrorWidget(onpressed: (){
          Navigator.pop(context);
          },
      )
      :Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 5,
            child: TopContainer(
              w: w, 
              avatar: usersProvider.currentUser?.avatar ??"",
              email:  usersProvider.currentUser?.email ??"N/A",
              username:  "${usersProvider.currentUser?.firstName} ${usersProvider.currentUser?.lastName}",
            )
          ),
          Expanded(
            flex: 5,
            child: UserDeatils(items: items)
        )
        ]
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.onpressed,
  });
  final Function() onpressed ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  double.infinity,
      height: double.infinity,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,          
        children: [
          const SizedBox(height: 30,),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(onPressed: onpressed,
             icon: const Icon(Icons.arrow_back_ios)),
          
          ),
          const Spacer(),
          const Text("حدث خطأ ما",
             style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.2,
                fontSize: 22
              ),
          ),
          const Text("يرجى إعادة المحاولة"),
          const Spacer(),
        ],
      ),
    );
  }
}

class UserDeatils extends StatelessWidget {
  const UserDeatils({
    super.key,
    required this.items,
  });

  final List<Map> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Row(
                children: [
                  Icon(items[i]['icon']),
                  const SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(items[i]['title'],
                       style:  TextStyle(
                        height: 1.0,
                        fontSize: 14,
                        color: Colors.grey[700]

                      ),
                    ),
                    Text(items[i]['value'], 
                      style: const TextStyle(
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ],)
                ],
              ),
            ),
          );
        },
      )
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
    required this.w,
    required this.username, 
    required this.avatar, 
    required this.email
  });
  final String avatar ;
  final String username ;
  final String email ;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30)
        ),
      gradient: RadialGradient(
        center: const Alignment(-0.8, -0.6),
          colors: [
            Theme.of(context).primaryColor.withAlpha(175) ,
            Theme.of(context).primaryColor ,
          ],
          radius: 1.25,
      ),
    ),
    child:   SizedBox(
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
          ),
          CircleAvatar(               
            backgroundColor: Colors.white,
            radius: w*0.16,
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: w*0.155,
            ),
          ),
          Text(username,
             style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(email,
             style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.0
            ),
          ),

        ],
      ),
    ),
    );
  }
}