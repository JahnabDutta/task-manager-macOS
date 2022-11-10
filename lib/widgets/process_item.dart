import 'package:flutter/material.dart';
import '../models/process.dart';

class ProcessItem extends StatelessWidget {
  const ProcessItem({Key? key, required this.process}) : super(key: key);

  final RunningProcess process;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23,
            spreadRadius: -13,
            color: Colors.black12,
          ),
        ],
      ),
      child: // add text information here
          Row(
        children: [
          Text(
            process.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
