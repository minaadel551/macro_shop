
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:macro_shop/screens/cart_screen.dart';
import 'package:macro_shop/widgets/methods_for_product_View.dart';
import '../consts.dart';

class HomePage extends StatefulWidget {
  static String id='home page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _tabBarIndex=0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
            child: Scaffold(
              backgroundColor:KMainOneColor ,
              appBar: AppBar(
                backgroundColor: KMainOneColor,
                elevation: 0,
                toolbarHeight: MediaQuery.of(context).size.height*0.15,
                bottom: TabBar(
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize:18,fontWeight: FontWeight.bold),
                  indicatorColor: Colors.yellowAccent[900],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[600],
                 indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                  tabs: [
                    Text('Jackets'),
                    Text('Trousers'),
                    Text('T-shirts'),
                    Text('Shoes'),
                  ],
                  onTap: (val){
                    setState(() {
                      _tabBarIndex=val;
                    });
                  },
                ),
              ),
              body: TabBarView(
                children: [
                  jacketView('jackets'),
                  jacketView('trousers'),
                  jacketView('t-shirt'),
                  jacketView('shoes'),
                 // productView('trousers'),
                 //  productView('t-shirt'),
                 //  productView('shoes'),
                ],
              ),

            ),
          ),

        Material(
          child: Container(
          decoration: BoxDecoration(
             border:  Border.all(width: 0,color: KMainOneColor),
            color: KMainOneColor,
          ),
            padding: EdgeInsets.only(top: 40,bottom: 0,right: 5,left: 20),
            height: MediaQuery.of(context).size.height*0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('DISCOVER',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                 Row(
                   children: [
                     gestureDetectorIcon(
                       onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                       child: badge(context: context, ),),
                     SizedBox(width: 8,),
                     gestureDetectorIcon(onTap: (){
                       final _auth =FirebaseAuth.instance;
                       _auth.signOut();
                     },child: Icon(Icons.logout))
                   ],
                 ),
               ],
            ),
          ),
        ),
      ],

    );
  }




}


