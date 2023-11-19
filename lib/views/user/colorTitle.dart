import 'package:flutter/material.dart';

class ColorTitle extends StatelessWidget {
  const ColorTitle({super.key,required this.icon, required this.color, required this.text});
  final IconData icon;
  final  Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15), 
      child: ListTile(
        tileColor: const Color.fromRGBO(224, 231, 233, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(text,style:const TextStyle(fontSize: 16),),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
      ),
    );
  }
}