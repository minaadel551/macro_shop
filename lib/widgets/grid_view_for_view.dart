import 'package:flutter/material.dart';
import 'package:macro_shop/product.dart';
import 'package:macro_shop/screens/product_info.dart';

class GridViewView extends StatelessWidget {
  final List<Product> products;



   GridViewView({ @required this.products,}) ;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:2/3
      ),
      itemCount: products.length,
      itemBuilder: (context, index) =>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
          } ,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(products[index].pLocation,fit: BoxFit.cover,)),
              Positioned(
                  bottom: 0,
                  child:Opacity(
                    opacity: 0.6,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].pName,style: TextStyle(fontWeight: FontWeight.w900),),
                              Text('${products[index].pPrice}\$',style: TextStyle(fontWeight: FontWeight.w900),),
                            ],
                          ),
                        )
                    ),
                  ) ),
            ],
          ),
        )
      ),

    );
  }
}
