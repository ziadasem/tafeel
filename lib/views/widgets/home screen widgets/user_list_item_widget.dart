import 'package:flutter/material.dart';
import 'package:tafeel/models/user.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({
    super.key,
    required this.currentUser,
    required this.onPressed
  });

  final User currentUser;
  final Function() onPressed ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [ 
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: NetworkImage(currentUser.avatar,),
                radius: 30,
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      RichText(
                        text: TextSpan(
                          text: currentUser.firstName,
                          style:  TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16
                          ),
                          children: [
                            TextSpan(
                              text:  " ${currentUser.lastName}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(currentUser.email)
                  ],
                )
              )
            ]
          ),
        )
      ),
    );
  }
}