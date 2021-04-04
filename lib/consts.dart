import 'package:flutter/material.dart';

const KMainColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.4, 0.7, 0.9],
    colors: [
      Color(0xfffd2231),
      Color(0xfff9229e),
      Color(0xfff84452),
      Color(0xfffd2231),
      //Color(0xfff8494e),
    ],

  ),
);

const KMainOneColor =Color(0xff04B5B4);

const String KProductsCollection = 'Products';
const String KProductsName = 'productName';
const String KProductsPrice = 'productPrice';
const String KProductsDescription = 'productDescription';
const String KProductsCategory = 'productCategory';
const String KProductsLocation = 'productLocation';
const String KProductsQuantity = 'productQuantity';



