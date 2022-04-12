import 'package:flutter/material.dart';
class ContainerOfDate extends StatelessWidget {
  final String date;
  const ContainerOfDate({Key key,this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(date,style: const TextStyle(color: Colors.white)),
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
      ),
    );
  }
}
