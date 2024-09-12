

import 'package:flutter/material.dart';

class RosterEditStatsDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RosterEditStatsDialogState();
  }



}

class RosterEditStatsDialogState extends State<RosterEditStatsDialog> {


  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Enter Game Stats"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("Enter Data: "),
            ],
          )
        ],
      ),
    );
  }
  
}