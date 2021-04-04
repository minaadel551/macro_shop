import 'package:flutter/material.dart';
import 'package:macro_shop/product.dart';

class InfoScreen extends ChangeNotifier{

bool keepMeLogin=false;

  List<Product> products=[];

  void addProducts(Product product){
    products.add(product);
    notifyListeners();
  }

  void deleteProducts(Product product){
    products.remove(product);
    notifyListeners();
  }

  void changeKeepMeLogin(bool val){
    keepMeLogin = val ;
    notifyListeners();
  }


}