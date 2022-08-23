import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  String url;

  ProfilePicture(this.url);

  @override
  Widget build(BuildContext context) {
    if(url=="")
      return Container(
        margin: EdgeInsets.all(2),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/images/profile.png",),
                fit: BoxFit.cover
            )

        ),

      );
    else
      return Container(
        margin: EdgeInsets.all(2),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover
            )

        ),

      );

  }
}
