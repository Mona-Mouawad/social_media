import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/shared/style/Icons.dart';

class MenuItemModel{
  String? text;
  IconData? icon;

  MenuItemModel({this.text,this.icon,});



  Map<String,dynamic> toMap()
  {
    return{
      'text':text,
      'image':icon,
    };
  }


}


class MenuItem{
  static List<MenuItemModel> items=[ItemSave,ItemDelete];
  static  MenuItemModel ItemSave = MenuItemModel(
  text:'Save' ,
  icon: IconBroken.Upload);

  static  MenuItemModel ItemDelete = MenuItemModel(
      text:'Delete' ,
      icon:IconBroken.Delete
  );
}









