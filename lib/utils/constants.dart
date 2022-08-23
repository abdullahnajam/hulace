import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';

/*const primaryColor=Color(0xffffab41);
const lightColor=Color(0xffffbb67);*/
const primaryColor=Colors.black;
const lightColor=Colors.black;
/*const primaryColor=Color(0xff8758fe);
const lightColor=Color(0xffaf54fc);*/
const bgColor=Color(0xfff6f7fb);
const secondaryColor=Colors.black;

final df = new DateFormat('dd/MM/yy');
final tf = new DateFormat('hh:mm');
final dtf = new DateFormat('dd/MM/yy hh:mm');

const kGoogleApiKey = "AIzaSyBhCef5WuAuPKRVoPuWQASD6avTs16x7uE";

const drawerHeadGradient=LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    lightColor,
    primaryColor,

  ],
  tileMode: TileMode.repeated,
);
const loremIpsum="Lorem ipsum dolor sit amet, consectetur adipiscing elit leo felis congue elit leo.";
const serverToken="AAAACfUoj6w:APA91bG8CBaXLESOehpvpFc6et30knT0ha9OrkKe3UK2FHQ3t5c8MeJdrpx9dRk8JCvMFuSEMO3oC5vDBMfzWQD955lRV63_dR308LHXavwLlkAUKYzuIcKX6_v_LYWKcttuGWjc1iCp";

Future<void> share() async {
  await FlutterShare.share(
      title: 'Hulace',
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title'
  );
}
