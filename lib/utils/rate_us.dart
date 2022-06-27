import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hulace/utils/constants.dart';

Future<void> showRateUsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Rate Hulace app!'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('If you enjoy using Hulace, please rate our app!'),
              RatingBar(
                initialRating: 5,
                glowColor: primaryColor,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star,color: primaryColor,),
                  half: Icon(Icons.star_half,color: primaryColor),
                  empty: Icon(Icons.star_border,color: primaryColor),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('LATER',style: TextStyle(color: primaryColor),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('RATE NOW',style: TextStyle(color: primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}