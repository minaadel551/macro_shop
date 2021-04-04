import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:macro_shop/product.dart';
import 'package:macro_shop/providers/info_screen_provider.dart';
import 'package:macro_shop/widgets/methods_for_product_View.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {
  static String id = 'cart screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<InfoScreen>(context).products;
   final double screenHeight = MediaQuery.of(context).size.height;
   final double width = MediaQuery.of(context).size.width;
   final appBarHeight = AppBar().preferredSize.height;
   final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('My Card',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: gestureDetectorIcon(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.of(context).pop();
          },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight * 0.83,
                child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Dismissible(
                          key: Key(products[index].pID),
                          background: dismissibleContainer(),
                         onDismissed: (DismissDirection direction){
                            Provider.of<InfoScreen>(context,listen: false).deleteProducts(products[index]);
                         },
                          confirmDismiss: (DismissDirection direction) async {
                            return await showAlert();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff384067),
                                borderRadius: BorderRadius.circular(10)),
                            height: screenHeight * 0.14,
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                CircleAvatar(
                                  radius: screenHeight * 0.14 / 2,
                                  backgroundImage:
                                      AssetImage(products[index].pLocation),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,right: 25),
                                  child: Column(
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          buildTextButton(
                                              child: Icon(Icons.add, color: Color(0xffFED859),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  products[index].pQuantity++;
                                                });
                                              }),
                                          Text('${products[index].pQuantity}',
                                              style: TextStyle(color: Colors.white, fontSize: 18)),
                                          buildTextButton(
                                              child: Icon(
                                                Icons.remove,
                                                color: products[index].pQuantity >1 ?Color(0xffFED859) : Colors.red.withOpacity(0.0),
                                              ),
                                              onTap: () {
                                                if (products[index].pQuantity >
                                                    1) {
                                                  setState(() {
                                                    products[index].pQuantity--;
                                                  });
                                                }
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                               SizedBox(
                                width: 5, child: Container(color: Color(0xffFED859),),
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                   '${price(products[index].pPrice, products[index].pQuantity)}',
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Container(
                height: screenHeight * 0.8,
                child: Center(
                  child: Text(
                    'Your Cart is Empty.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              );
            }
          },
        ),
            if (products.isNotEmpty)
        SizedBox(
          width:width,
          height: screenHeight - ((screenHeight * 0.83)+statusBarHeight+appBarHeight),
          child: TextButton(
            onPressed: () {
              showPopup(products);
            },
            child: Text('ORDER',style: TextStyle(color: Colors.black),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFED859)),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)))),
            ),
          ),
        ),
      ]),
    );
  }

Widget dismissibleContainer (){
 return Container(
   decoration: BoxDecoration(
       color: Color(0xffFED859),
       borderRadius: BorderRadius.circular(10)),
    alignment:Alignment.centerLeft,

    child: Row(
      children: [
        Icon(Icons.delete,color: Colors.black,),
        Text('Delete',style: TextStyle(color: Colors.black),),
      ],
    ),
   );

}

  showAlert()async {
     return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this item?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(message: 'Item Deleted'));

        },
                child: const Text("DELETE")
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }



 showPopup (List<Product>products){

   int price =0;
   for(var product in products){
     price += product.pQuantity * int.parse(product.pPrice);
   }
   final popup = BeautifulPopup(
     context: context,
     template: TemplateCoin,
   );
   popup.show(
     title: 'Total Price',
     content: Column(
       children: [
         Text('${price.toString()}\$',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

       ],
     ),
     actions: [
       popup.button(
         label: 'Close',
         onPressed: Navigator.of(context).pop,
       ),
       popup.button(
         label: 'Order Now',
         onPressed: Navigator.of(context).pop,

   ),
   ],
   // bool barrierDismissible = false,
   // Widget close,
   );
   }



 }



