import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class text_style {
  
  static const TextStyle text_style1 = TextStyle(
        fontFamily: "Poppins-3",
        color: custom_color.c_dark_blue, 
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

  static const TextStyle text_style4 = TextStyle(
        fontFamily: "Poppins-2",
        color: Color(0xFFeb5e28),
        fontWeight: FontWeight.w600,
        fontSize: 12, 
        );  
  
  static const TextStyle text_style5 = TextStyle(
        fontFamily: "Poppins-3",
        color: Color.fromARGB(255, 161, 170, 161),
        fontWeight: FontWeight.w100,
        fontSize: 12, 
        );  

  static const TextStyle text_style6 = TextStyle(
        fontFamily: "Poppins-2",
        color: custom_color.c_dark_blue, 
        fontWeight: FontWeight.w600,
        fontSize: 12, 
        );

  static const TextStyle text_style7 = TextStyle(
        fontFamily: "Poppins-2",
        color: custom_color.c_dark_blue, 
        fontWeight: FontWeight.w600,
        fontSize: 24, 
        );    
  
  static const TextStyle text_style8 = TextStyle(
        fontFamily: "Poppins-2",
        color: custom_color.c_dark_blue, 
        fontWeight: FontWeight.w600,
        fontSize: 13, 
        );    
  
  static const TextStyle text_style9 = TextStyle(
        fontFamily: "Poppins-3",
        color: custom_color.c_orange,
        fontWeight: FontWeight.w100,
        fontSize: 12, 
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


String formatDate(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}


class Peso{
  static final pesoFormatter = NumberFormat.currency(locale: 'es-PH', name: 'P');
  static String symbol = pesoFormatter.currencySymbol; 
}