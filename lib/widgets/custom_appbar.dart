import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(

        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                padding: EdgeInsets.all(7),
                child: Icon(Icons.arrow_back_ios_sharp,size: 15,),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
}
