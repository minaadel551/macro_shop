import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:macro_shop/providers/info_screen_provider.dart';
import 'package:macro_shop/screens/cart_screen.dart';
import 'package:macro_shop/screens/home_page.dart';
import 'package:macro_shop/screens/login.dart';
import 'package:macro_shop/screens/product_info.dart';
import 'package:provider/provider.dart';
import 'fireStore/auth.dart';

void main() {
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider<Auth>(
          create: (_)=>Auth(),),
      ChangeNotifierProvider<InfoScreen>(
        create: (_)=>InfoScreen(),),
    ],
    child:  MyApp()),

     );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor:  Colors.yellowAccent,
      ),
      title: 'Macro Shop',
      home:StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,
        builder:(ctx,snapshot){
          if(snapshot.hasData) {
            return HomePage();
          } else {
            return LoginScreen();
          }
        },
      ),
      routes: {
        LoginScreen.id:(context)=>LoginScreen(),
        HomePage.id:(context)=>HomePage(),
        ProductInfo.id:(context)=>ProductInfo(),
        CartScreen.id:(context)=>CartScreen(),


      },
    );
  }
}

