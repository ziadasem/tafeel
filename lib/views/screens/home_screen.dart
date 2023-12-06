
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/config/app_const.dart';
import 'package:tafeel/utils/next_screen.dart';
import 'package:tafeel/views/screens/search_screen.dart';
import 'package:tafeel/views/screens/user_detail_screen.dart';
import 'package:tafeel/views/widgets/empty_ui_widget.dart';
import 'package:tafeel/views/widgets/home%20screen%20widgets/user_list_item_widget.dart';
import 'package:tafeel/vm/users_provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ScrollController scrollController = ScrollController();
  bool latch = false ;
  late UsersProvider usersProvider;
  
  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of<UsersProvider>(context);
    final double h = MediaQuery.of(context).size.height ;
    final double w = MediaQuery.of(context).size.width ;
    scrollController.addListener(detectingEdgeListner);
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle:  true,
        foregroundColor: Colors.black,
        title: const Text(AppConst.appName,
                           style: TextStyle(
                              fontSize: 20),
                      ),
        actions: [
          IconButton(onPressed: ()=> search(context), 
            icon:const Icon(Icons.search)
          )
        ],
      ),
      body: usersProvider.users.isEmpty 
        ? EmptyUI(h:h, w: w):
        ListView.builder(
          itemCount: usersProvider.users.length + 1,
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index ==  usersProvider.users.length){
              return usersProvider.isLoading ? const Center(child:  CircularProgressIndicator()) : Container();
            }
            return UsersListItem(
              currentUser: usersProvider.users[index],
              onPressed: () async{
                usersProvider.getSingleUser(usersProvider.users[index].id.toString())  ;
                nextScreen(context, const UserDetailScreen());
              },
            );
          },
        ),
    );
  }

  void detectingEdgeListner() async{
    if (scrollController.position.atEdge &&
        scrollController.position.pixels ==
        scrollController.position.maxScrollExtent && !latch) {
        latch = true ;
        await usersProvider.getUsers();
        latch = false ;
      }
  }

  void search(BuildContext context){
    usersProvider.emptyDisplayedUSers();
    nextScreen(context, const SearchScreen());
  }
}

