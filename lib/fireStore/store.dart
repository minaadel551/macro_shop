import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macro_shop/consts.dart';
import 'package:macro_shop/product.dart';

class Store{

final Firestore _fireStore = Firestore.instance;


/// *  ميثود بتخزن علي ال fireStore    */
// بتاخد class فيه الحاجات اللي بتتخزن علشان مبعتهاش واحده واحدة
// وانا بستدعيها هديها Product في العناصر اللي هخزنها علي ال firebase
  addProduct(Product product){
    // كل اللي عليا هستدعي ال method دي وهي هتقوم بالواجب
    /**
     *  هنا بقوله روح علي ال collection اللي اسمها product
     *   لو موجوده هيحفظ فيها لو لا هيعملها
     *     عملتها متغير في ال const علشان الحروف بعد كدا وانا بكتب متبقاش فيها غلط
     */

    _fireStore.collection(KProductsCollection).add({
      /**
       * ال data هتتخزن علي هيئه map يعني String و value
       * يعني علشان ابعت ال data لل fireStore عندي طريقتين
       * 1-  map
       * {'String : value, ... الخ}
       * 2- اعمل class واديله الحاجة وانا بستدعيه
       * وانا بجبها بردو هستخدم ال String سواء مع الطريقه الاولي او الثانيه  فوارد اني اغلط في حرف فعلشان كدا عملته برده const
       */
      KProductsName:product.pName ,
      KProductsCategory:product.pCategory ,
      KProductsDescription:product.pDescription ,
      KProductsLocation:product.pLocation ,
      KProductsPrice:product.pPrice ,

    });
    // الاستخدام
    // هعمل object من ال class وهستدعي الميثود دي وههتيها ال product بالبيانات
  }

// ignore: slash_for_doc_comments
/**
 * لو حصل مشكله اثناء ال run او التخزين 
 * هروح لل android ثم ال app ثم ال build.gradle
 *   buildTypes {
    release { .... }
    // وهكتب ال debug دي بعد ال release
    debug{
    minifyEnabled true
    }
    }
 */



  /// *  دي ميثود هتجبلي البيانات اللي متخزنه في ال fireStore    */
  // هترجعلي ال stream نفسه
  Stream <QuerySnapshot>loadProduct() {
    /**
     * لازم يكون نفس ال collection اللي مخزن فيه البيانات
     * ال snapshots دي بترجعلي stream
     * و ال stream  دي عباره عن قناه وانا بستقبل منها كل اللي بتبعته اوا بأول
     * فهعمل عليها loop علشان اوصل لكل ال data اللي فيها
     */
    //  مينفعش استخدم return داخل اقواس ال stream علشان هتوقفها فلازم احطها براها

  return _fireStore.collection(KProductsCollection).snapshots();

     // الاستخدام
   // هعمل object من ال class دا وهحط الحاجة اللي جايه داخل ال StreamBuilder

    // StreamBuilder<QuerySnapshot>(   // بقوله ابني الحاجة دي بس خلي بالك انها هتيجي في المستقبل  وخليك مهاها علشان هتبعتلك كل شويهوبحدد ان ال data اللي جايه من نوع QuerySnapshot
    //         stream: _store.loadProduct(),       // الحاجه هتجيلي من المكان دا
    //         builder:(context, snapshot) {
    //           if(snapshot.hasData) {            // لو فيها داتا "يعني لما يحمل الداتا من النت"
    //             List<Product> products=[];     // دي الحاجة اللي هترجع اللي هتكون فيها الداتا لازم اعرفها هنا علشان لما يعمل refresh يبنيها من اول وجديد و الداتا متظهرش اكتر من مره
    //             for (var doc in snapshot.data.documents){
    //               var data =doc.data;
    //               /**
    //                * هضيف البيانات في ال List اللي عملتها
    //                * وهي عباره عن LIST من ال product فطبعا هملا العناصر اللي بياخدها
    //                * فبدل مكتب العناصر يدوي كنت عاملها const علشان متلغبطش في الحروف
    //                */
    //               products.add(Product(
    //                 pPrice: data[KProductsPrice],pName: data[KProductsName],pLocation: data[KProductsLocation],
    //                 pDescription: data[KProductsDescription],pCategory: data[KProductsCategory],
    //               ));
    //             }
    //             return ListView
    //                 .builder( // الحاجة اللي هتتبني من البيانات اللي جايه من المستقبل وهتكون في ال List "يعني لما احب اوصل للبيانات هكتب اسم ال List[الرقم index].الحاجة"
    //               itemBuilder: (context, index) => Text(products[index].pName),
    //               itemCount: products.length,
    //             );
    //           }else{
    //             return Center(child: Text('Loading ....'));  // علشان الداتا هتتاخر علي حسب النت فميظهرش Error



  }












}








