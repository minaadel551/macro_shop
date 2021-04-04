import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_shop/consts.dart';
import 'package:macro_shop/fireStore/auth.dart';
import 'package:macro_shop/providers/info_screen_provider.dart';
import 'package:macro_shop/screens/home_page.dart';
import 'package:macro_shop/widgets/login_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

  static const String id = 'login';

  String email, password;
  final GlobalKey<FormState>_globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var haveAcc = Provider.of<Auth>(context).isHaveAcc;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: KMainColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<Auth>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                // for icon logo and text 'macro shop'
                Padding(
                  padding: EdgeInsets.only(top: height * 0.065),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Image.asset('images/store.png', height: 190,),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Text('Macro Shop ',
                            style: TextStyle(fontFamily: 'pacifico',
                                fontSize: 26),)),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01,),

                if(!haveAcc)
                  AuthTextField(icon: Icons.person,
                    hint: 'Enter your Name ',
                    inputType: TextInputType.name,),

                AuthTextField(icon: Icons.email,
                  hint: 'Enter your Email ',
                  inputType: TextInputType.emailAddress,
                  onSave: (val) {
                    email = val;
                  },),
                AuthTextField(icon: Icons.lock,
                  hint: 'Enter your Password ',
                  inputType: TextInputType.visiblePassword,
                  scure: true,
                  onSave: (val) {
                    password = val;
                  },),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Remember Me',style: TextStyle(fontWeight: FontWeight.bold),),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.teal[100],),
                      child: Checkbox(
                         value: Provider.of<InfoScreen>(context).keepMeLogin,
                          onChanged: (bool val){
                                 Provider.of<InfoScreen>(context,listen: false).changeKeepMeLogin(val);},
                           activeColor: Colors.red[900],
                           checkColor: Colors.yellow,
                          overlayColor: MaterialStateProperty.all(Colors.deepPurple),


                      ),
                    ),
                  ],
                ),
                // for button 'login or sing up'
                Padding(
                  padding: EdgeInsets.only(top: height * 0.06,
                      right: width * 0.3,
                      left: width * 0.3,
                      bottom: 0),
                  child: TextButton(
                    onPressed: () async {
                      submitAuthForm(context, haveAcc);
                    },
                    child: Text(haveAcc ? 'Login' : 'Sign up',
                      style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),)),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),

                  ),
                ),


                // for button to switch login and sing up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(haveAcc
                        ? "Don't have an account ?"
                        : "Do have an account ?"
                      , style: TextStyle(color: Colors.white),),
                    TextButton(
                      onPressed: () {
                        Provider.of<Auth>(context, listen: false).changeHaveAcc();
                        _globalKey.currentState.reset();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(haveAcc ? 'Sing up' : 'Login',
                        style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitAuthForm(BuildContext ctx, bool haveAcc) async {
    final modalHud = Provider.of<Auth>(ctx, listen: false);
    modalHud.changeLoading(true);
    FocusScope.of(ctx).unfocus();
    /**    لو كانت القيمه اللي المستخدم مدخلها صالحة كمل*/
    if (_globalKey.currentState.validate()) {
      /** هعمل حفظ للبيانات الداخله من المستخدم */
      _globalKey.currentState.save();

      /** هحاول اعمل تسجيل دخول او انشاء حساب مع علامة التحميل
       * واشوف لو فيه خطأ هعرضه في ال snackBar
       * علامه التحميل بخليها true عند الضغط علي الزر "علشان تظهر "
       * وتختفي لما ال auth يخلص قبل ال navigator لو كان تمام
       * او تختفي لو حصل مشكله قبل ال snackBar
       */
      try {
        if (haveAcc == false) {
          /** لازم المتغير ولازم ال await علشان اخلي البرنامج ينتظر لحد ما ال auth يخلص
           * لو انتهي و دخل يكمل اللي بعده "ينقلني للصفحة اللي بعدها "
           * لو حصل مشكله ميكملش
           */
          // بكتب .trim() علشان لو المستخدم داس علي ال space بالخطا في الاول او الاخر متتسجلش بيها
           await Provider.of<Auth>(ctx, listen: false)
              .signUp(email.trim(), password.trim());
          modalHud.changeLoading(false);
          Navigator.pushReplacementNamed(ctx, HomePage.id);
        } else {
           await Provider.of<Auth>(ctx, listen: false)
              .signIn(email.trim(), password.trim());
          modalHud.changeLoading(false);
          Navigator.pushReplacementNamed(ctx, HomePage.id);
        }
      } on PlatformException catch (e) {
        modalHud.changeLoading(false);
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(e.message),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ));
      } catch (e) {
        modalHud.changeLoading(false);
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(e.toString()),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ));
      }

    }

    modalHud.changeLoading(false);
  }


}
