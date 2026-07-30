import 'package:flutter/material.dart';

class Sinupbottion extends StatelessWidget {

  final void Function()? onPressed;

  final String text;

  const Sinupbottion({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return
    
     Row(

      mainAxisAlignment: MainAxisAlignment.center,
       children: [

        
         Container(
          padding: EdgeInsets.only(left: 0,right: 0),
          width: 222,
         height: 45,
         
         decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Color(0x8C000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
         
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(50, 45),
         padding: EdgeInsets.zero,
         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: const Color(0xFFE7E7EE),
              elevation: 0,
         
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
         
            onPressed: onPressed,
         
            child: Text(
              text,
         
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF4B1A23),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
             ),
       ],
     );
  }
}