import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hulace/provider/ChatProvider.dart';
import 'package:hulace/provider/UserDataProvider.dart';
import 'package:hulace/splash.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hulace',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
