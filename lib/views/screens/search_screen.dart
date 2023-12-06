import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel/utils/next_screen.dart';
import 'package:tafeel/views/screens/user_detail_screen.dart';
import 'package:tafeel/views/widgets/empty_ui_widget.dart';
import 'package:tafeel/views/widgets/home%20screen%20widgets/user_list_item_widget.dart';
import 'package:tafeel/vm/users_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  final TextEditingController textEditingController = TextEditingController();

  late double h ;
  late double w ;

  late UsersProvider usersProvider;

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of<UsersProvider>(context);
    h = MediaQuery.of(context).size.height ;
    w = MediaQuery.of(context).size.width ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle:  true,
        foregroundColor: Colors.black,
        title: const Text("Search",
                        style: TextStyle(
                              fontSize: 20),
                      ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: w*0.68,
                      height: 40,
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: InkWell(onTap: (){
                          setState(() {
                            textEditingController.clear();
                           FocusManager.instance.primaryFocus?.unfocus();
                          });
                        }, child: const Icon(Icons.close)),
                        border:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.only(left: 0, right: 10),
                      ),
                      onChanged: (val){
                       usersProvider.searchForUser(val);
                      },
                      validator: (value) {
                                        if (value!.isEmpty) return 'القيمة مطلوبة'; 
                                        return null;                                
                                      },
                                    ),
                    ), 
                    const Spacer(),
                    SizedBox(
                      width: w*0.22,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                        onPressed: (){
                          //search();
                      }, child: const Text("Search")),
                    ),
                  
                ],
              ),
          ),
            //const Spacer(),
            Expanded(
              //flex: 8,
              child: usersProvider.displayedUser.isEmpty ? EmptyUI(h: h, w: w) 
              :ListView.builder(
                itemCount: usersProvider.displayedUser.length ,
                itemBuilder: (context, index) {
                  return UsersListItem(
                    currentUser: usersProvider.displayedUser[index],
                    onPressed: () {
                      usersProvider.getSingleUser(usersProvider.users[index].id.toString())  ;
                      nextScreen(context, const UserDetailScreen());
                    },
                  );
                },
              )
            )
        ],
      ),
    );
  }

  void search(){
    usersProvider.searchForUser(textEditingController.text);
  }
}