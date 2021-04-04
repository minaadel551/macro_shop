import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final bool scure;
  final TextInputType inputType;
  final Function onSave;

  AuthTextField({ @required this.icon,@required this.hint,@required this.inputType, this.onSave,this.scure=false});

  String errorMessage(){
    if(hint =='Enter your Name '){
      return 'wrong name';
    }else  if(hint =='Enter your Email '){
      return 'wrong email';
    }else  if(hint =='Enter your Password '){
      return 'wrong password';
    }else return 'wrong value';

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical:height *0.01,horizontal: width*0.055),
      child: TextFormField(

        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return errorMessage();
          }
        },
        cursorColor: Colors.red[900],
        obscureText: scure,
        keyboardType: inputType,
        onSaved: onSave,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange[200]),
              borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange[200]),
              borderRadius: BorderRadius.circular(20)
          ),
          hintText: hint,
          fillColor:  Colors.orange[200],
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: Icon(icon,color: Colors.redAccent[400],),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange[200]),
              borderRadius: BorderRadius.circular(20)
          ),
         errorStyle: TextStyle(color: Colors.white)



        ),
      ),
    );
  }
}
