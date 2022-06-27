import 'dart:convert';
import 'package:flutter/material.dart';

const primaryColor=Color(0xffffab41);
const lightColor=Color(0xffffbb67);
const bgColor=Color(0xfff6f7fb);
const secondaryColor=Color(0xff12142f);

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
