import 'package:flutter/material.dart';

class EmptyUI extends StatelessWidget {
  final double h;
  final double w ;
  const EmptyUI({
    Key? key,
   required this.h ,required this.w
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_results.png" ,
                                 fit: BoxFit.scaleDown,
                                 height: h * 0.3,width: w*0.5,
                                ),
                   const Text( "No elements are available", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700, fontSize: 24),),
                  ],
                ),
              );
  }
}