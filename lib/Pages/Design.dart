import 'package:flutter/material.dart';


class text_style {
  
  static const TextStyle text_style1 = TextStyle(
        fontFamily: "Poppins-3",
        color: Color(0xFF3a3937), 
        fontWeight: FontWeight.w600,
        fontSize: 16, 
        ); 
  
  static const TextStyle text_style2 = TextStyle(
        fontFamily: "Poppins-3",
        color: Color(0xFFF2F2F2), 
        fontWeight: FontWeight.w600,
        fontSize: 16, 
        ); 

  static const TextStyle text_style3 = TextStyle(
        fontFamily: "Poppins-2",
        color: Color(0xFFF2F2F2), 
        fontWeight: FontWeight.w600,
        fontSize: 24, 
        ); 
}

class input_border {

  static OutlineInputBorder enabled = OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFFFFFFF),
                                    width : 2.0,
                                  )
                                );

  static OutlineInputBorder error = OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color:  Color(0xFFFFFFFF),
                                  width : 2.0,
                                )
                              );

  static OutlineInputBorder focus = OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF333333),
                                    width : 2.0,
                                  )
                                ); 

  
}

class custom_color {
  static const c_orange = Color(0xFFeb5e28);
  static const c_offwhite = Color(0xFFFAFAFA);
  static const c_dark = Color(0xFF333333);   
  static const c_dark_blue = Color(0xFF04193B);   

}