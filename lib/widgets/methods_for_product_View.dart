import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:macro_shop/product.dart';
import 'package:macro_shop/consts.dart';
import 'package:macro_shop/fireStore/store.dart';
import 'package:macro_shop/providers/info_screen_provider.dart';
import 'package:macro_shop/widgets/grid_view_for_view.dart';
import 'package:provider/provider.dart';

final _store=Store();
List <Product> _product ;

Widget jacketView(String category) {
  return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder:(context, snapshot) {
        if(snapshot.hasData) {
          List<Product> products=[];
          for (var doc in snapshot.data.documents){
            var data =doc.data;

            products.add(Product(
                pPrice: data[KProductsPrice],pName: data[KProductsName],pLocation: data[KProductsLocation],
                pDescription: data[KProductsDescription],pCategory: data[KProductsCategory],pID: doc.documentID
            ));
          }

          // من هنا لقبل ال return دا ال logic اللي هيخليني اعرض بس منتج معين "jackets"
          _product = [... products];
          products.clear();
          products= getProductByCat(category);
          return GridViewView(products: products,);
        }else{
          return Center(child: Text('Loading ....'));
        }

      }
  );
}

List<Product> getProductByCat(String category) {
  List<Product> products=[];
  try{
    for (var product in _product){
      if(product.pCategory == category){
        products.add(product);
      }
    }
  }on Error catch(e) {
    print(e);
  }

  return products;
}

Widget productView(String cat) {
  List<Product> products;
  products = getProductByCat(cat);
  return    GridViewView(products: products,);
}

Widget gestureDetectorIcon({Function onTap,Widget child}){
  return GestureDetector(
    onTap: onTap,
    child: child,
  );
}

buildTextButton({Widget child, Function onTap}) {
  return TextButton(
      onPressed: onTap,
      child: child);
}

SnackBar snackBar({@required String message}){
  return SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text(message),
      padding: EdgeInsets.only(left: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)))
  );
}

Widget badge ({@required BuildContext context}){
  int num =Provider.of<InfoScreen>(context).products.length;
if(num > 0 )
  return Badge(
    elevation: 5,
    badgeContent: Text( num.toString()),
    badgeColor: Colors.redAccent,
    animationType: BadgeAnimationType.slide,
    shape: BadgeShape.square,
    borderRadius: BorderRadius.circular(20),
    padding: EdgeInsets.only(bottom: 1,right: 2,left: 2,top: 1),
    position: BadgePosition.topStart(top: -9,start: 10),
    child: Icon(Icons.shopping_cart),
  );
else return Icon(Icons.shopping_cart);


}


String price (price , quantity ){
  int finalPrice = int.parse(price) *quantity;
  return '${finalPrice.toString()}\$';
}