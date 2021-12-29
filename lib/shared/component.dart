import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/shared/style/colors/colors.dart';

var uid='';
String token ="";

Widget defultTextField ({
  required context,
  TextEditingController? controller,
  TextInputType? type,
  String? labal,
  IconData? prefix , suffix, suffixpressed,
  String? initivalue,
  Function(String)? onsubmit ,onchange , ontap,
 required String? Function(String?) vaildate,
 bool ispassword =false,  enable =true,

})=>Container(
  decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),
  //color: defultcolor
  ) ,
  child:   TextFormField(
  controller: controller ,
  keyboardType:type ,
  obscureText: ispassword,
  textAlign: TextAlign.start,
  decoration: InputDecoration(
   // disabledBorder:InputBorder(borderSide: BorderSide.none)) ,
      labelText: labal,
     fillColor: defultcolor,
     focusColor: defultcolor,
     hoverColor: defultcolor,
     suffixIcon: suffix !=null ?IconButton(
     onPressed: suffixpressed,
     icon:Icon(suffix,
     color: defultcolor,) ) :null,
      prefixIcon: Icon(prefix,
       color: defultcolor,),
   ),
  
    validator:vaildate ,  
  
    onChanged: onchange,
  
    onTap: ontap,
  
    onFieldSubmitted: onsubmit,
  
    initialValue: initivalue,
  
   style: Theme.of(context).textTheme.bodyText1,
  
  ),
);

Widget defultButton({
  required String text,
  required VoidCallback ontap
})=>Container(
height: 50,
width: double.infinity,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: defultcolor,
),
child: MaterialButton(
  onPressed: ontap,
  child: Text(text,style: TextStyle(color: Colors.white,
  fontWeight: FontWeight.bold
),
),
),

);

Widget defultTextButton({
  required String text,
  required VoidCallback ontap})=>
  TextButton(
  onPressed: ontap,
  child: Text(text.toUpperCase(),style: TextStyle(color: defultcolor,fontWeight: FontWeight.w500),),
);


void toast({
  required String text,
  required toastStates state
  })=>Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
    enum toastStates{Success,Error,Warning}

    Color toastColor(toastStates state){
      Color ?color;
      switch (state) {
        case toastStates.Success :
         color= Colors.green;
          break;
        case toastStates.Error :
         color= Colors.red;
          break;  
        default:
        color= Colors.yellow;
      }
       return color;
    }

void NavigatorTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget));

void NavigatorAndFinish(context,Widget){
  Navigator.pushAndRemoveUntil(context,
   MaterialPageRoute(builder:(context)=> Widget),
   (route){return false;});
}

Widget myDivited()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
  child:   Container(width: double.infinity,height: .8,
  color: defultcolor.withOpacity(.5),),
);

