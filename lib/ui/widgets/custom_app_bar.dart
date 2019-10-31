import 'package:flutter/material.dart';

class CustomAppBar extends AppBar{
  CustomAppBar({String appBarTitle,IconData leadingIcon, BuildContext context})
      :super(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title:Text(
        appBarTitle,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
      leading : leadingIcon != null ? IconButton(
        icon: Icon(
          leadingIcon,
          color: Colors.black,
          size: 15.0,
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ) : null
  );
}