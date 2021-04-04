/// **                                          *****
///               الملف دا خاص بتسجيل الدخول فقط         *****

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';



// هحتاج احمل package ال
//1-  firebase_auth:
//2- modal_progress_hud:
//3- provider:

class Auth extends ChangeNotifier{

  final _auth =FirebaseAuth.instance;

  bool isHaveAcc = false;
  //   علشان اغير من ال
  // 1- TextFormField اللي عاوزها
  //2- استدعي الميثود المناسبة "تسجيل الدخول او انشاء حساب جديد "
  // 3- النصوص


  bool isLoading = false; // علشان علامه ال loading تظهر وتختفي


  // ميثود علشان اغير تسجيل الدخول او انشاء حساب
  changeHaveAcc(){
    isHaveAcc = ! isHaveAcc;
    notifyListeners();
  }

  // ميثود علشان اغير علامه التحميل "تظهر وتختفي"
  changeLoading(bool val){
    isLoading = val;
    notifyListeners();
  }



  // ال future دي معناها ان ال return هيجيلك كمان شوية مش now
  Future  signUp (String email,String password)async{
    /** الميثود دي علشان اعمل حساب جديد بالايميل والباسورد*/
    final authResult =await _auth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return authResult;

  }

  
  Future  signIn (String email,String password)async{
    /** الميثود دي علشان اعمل تسجيل دخول بالايميل والباسورد*/
    final authResult =await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return authResult;
  }

  Future signOut()async{
    await _auth.signOut();
  }


}



/** لما اضغط علي الزر*/
//   void submitAuthForm(BuildContext ctx, bool haveAcc) async {
//     final modalHud = Provider.of<Auth>(ctx, listen: false);
//     modalHud.changeLoading(true);
//     FocusScope.of(ctx).unfocus();
//     /**    لو كانت القيمه اللي المستخدم مدخلها صالحة كمل*/
//     if (_globalKey.currentState.validate()) {
//       /** هعمل حفظ للبيانات الداخله من المستخدم */
//       _globalKey.currentState.save();
//
//       /** هحاول اعمل تسجيل دخول او انشاء حساب مع علامة التحميل
//        * واشوف لو فيه خطأ هعرضه في ال snackBar
//        * علامه التحميل بخليها true عند الضغط علي الزر "علشان تظهر "
//        * وتختفي لما ال auth يخلص قبل ال navigator لو كان تمام
//        * او تختفي لو حصل مشكله قبل ال snackBar
//        */
//       try {
//         if (haveAcc == false) {
//           /** لازم المتغير ولازم ال await علشان اخلي البرنامج ينتظر لحد ما ال auth يخلص
//            * لو انتهي و دخل يكمل اللي بعده "ينقلني للصفحة اللي بعدها "
//            * لو حصل مشكله ميكملش
//            */
//           // بكتب .trim() علشان لو المستخدم داس علي ال space بالخطا في الاول او الاخر متتسجلش بيها
//            await Provider.of<Auth>(ctx, listen: false)
//               .signUp(email.trim(), password.trim());
//           modalHud.changeLoading(false);
//           Navigator.pushReplacementNamed(ctx, HomePage.id);
//         } else {
//            await Provider.of<Auth>(ctx, listen: false)
//               .signIn(email.trim(), password.trim());
//           modalHud.changeLoading(false);
//           Navigator.pushReplacementNamed(ctx, HomePage.id);
//         }
//       } on PlatformException catch (e) {
//         modalHud.changeLoading(false);
//         ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
//           content: Text(e.message),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(50))),
//         ));
//       } catch (e) {
//         modalHud.changeLoading(false);
//         ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
//           content: Text(e.toString()),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(50))),
//         ));
//       }
//
//     }
//
//     modalHud.changeLoading(false);
//   }


/**   */

//   on FirebaseAuthException catch (e) {
//     String message = 'error occurred';
//     if (e.code == 'weak-password') {
//       message=('The password provided is too weak.');
//     }
//     else if (e.code == 'email-already-in-use') {
//       message=('The account already exists for that email.');
//     }
//     else  if (e.code == 'user-not-found') {
//       message=('No user found for that email.');
//     }
//     else if (e.code == 'wrong-password') {
//       message=('Wrong password provided for that user.');
//     }
// ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
// content: Text(message),
// backgroundColor: Theme.of(ctx).errorColor,));
//   }//