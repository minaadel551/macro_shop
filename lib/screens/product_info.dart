import 'package:flutter/material.dart';
import 'package:macro_shop/product.dart';
import 'package:macro_shop/providers/info_screen_provider.dart';
import 'package:macro_shop/screens/cart_screen.dart';
import 'package:macro_shop/widgets/methods_for_product_View.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id='product Info';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  var textStyle= TextStyle(color: Colors.white,fontSize: 18);

  @override
  Widget build(BuildContext context) {

    Product product =ModalRoute.of(context).settings.arguments;
    final double width= MediaQuery.of(context).size.width;
    final double height= MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFED859),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 40,left: 15,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: gestureDetectorIcon(
                      child:Icon(Icons.arrow_back_ios_outlined,size: 18,),
                        onTap: (){
                                  Navigator.of(context).pop();
                            },),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),

                ),
                Text('Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),

                Row(
                  children: [
                    gestureDetectorIcon(
                      onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                        child: badge(context: context, ),),

                  ],
                ),




              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100,left: 2,right:2),
            child: Container(
              width:width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 15),
                    child: Text(product.pName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:11,right:15 ,left:15 ),
                    child: Text(product.pDescription),
                  ),
                  Container(
                     height: height*0.55,
                      child: Image.asset(product.pLocation))


                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0, left: 2,right: 2,
            child: Container(
            padding: EdgeInsets.only(top: 20),
            //  height: (height - statusBarHeight+12)*0.2 ,
              height: (height - statusBarHeight)*0.16 ,
              width:width,
              decoration: BoxDecoration(
                  color: Color(0xff384067),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
             child: SingleChildScrollView(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 15,bottom: 15),
                         child: Text('Price',style: textStyle,),
                       ),
                       Text(price(product.pPrice, _quantity),style: textStyle)
                     ],
                   ),
                   Column(
                     children: [
                       Row(
                         children: [
                           buildTextButton(child:Icon(Icons.add,color:Color(0xffFED859) ,),
                               onTap:(){
                             setState(() {
                               _quantity ++;
                             });

                           }),
                           Text('$_quantity',style:textStyle),
                          buildTextButton(child:Icon(Icons.remove,color:_quantity>1? Color(0xffFED859): Colors.red.withOpacity(0.0),),
                              onTap:(){
                            if(_quantity > 1){
                              setState(() {
                                _quantity--;
                              });

                            }
                          //  Provider.of<InfoScreen>(context,listen: false).decreaseNumOfProduct();
                          }),
                         ],

                       ),

                       buildTextButton(
                           child:Text('Add To Card'.toUpperCase(),
                           style: TextStyle(color: Color(0xffFED859),fontWeight: FontWeight.w700,)),
                           onTap:(){
                             addToCart(product);
                           }),

                     ],
                   )
                 ],
               ),
             )
            ),
          ),

        ],
      ),
    );
  }
void addToCart( product){

  product.pQuantity= _quantity;
  bool exit = false;
  var productsInCart =Provider.of<InfoScreen>(context,listen: false).products ;
  for(var productInCart in productsInCart){
    if (productInCart.pName == product.pName){
      exit = true;
    }
  }
  if(exit){
    ScaffoldMessenger.of(context).showSnackBar(snackBar(message: ' You\'ve added this item before'));
  }
  else{
    Provider.of<InfoScreen>(context,listen: false).addProducts(product);
    ScaffoldMessenger.of(context).showSnackBar(snackBar(message: ' Added to Cart.'));

  }

}



}
