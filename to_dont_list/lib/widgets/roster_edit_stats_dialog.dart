import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//cut text editing controller, idk if that is needed
typedef RosterStatsUpdatedCallback = Function(
    bool starter, int minutesPlayed, int fieldGoalsAttempted, int fieldGoalsMade, int threePtAttempted, int threePtMade, int freeThrowsAttempted, int freeThrowsMade, int offensiveRebounds, int defensiveRebounds, int assists, int steals); 

class RosterEditStatsDialog extends StatefulWidget{
  const RosterEditStatsDialog({super.key});

  // final RosterStatsUpdatedCallback onStatsUpdated;

  @override
  State<StatefulWidget> createState() {
    return RosterEditStatsDialogState();
  }



}
//what is the difference between a widget and a state???

class RosterEditStatsDialogState extends State<RosterEditStatsDialog> {

bool starter = false;
int minutesPlayed = 0;
int fieldGoalsAttempted = 0;
int fieldGoalsMade = 0;
int threePtAttempted = 0;
int threePtMade = 0;
int freeThrowsAttempted = 0;
int freeThrowsMade = 0;
int offensiveRebounds = 0;
int defensiveRebounds = 0;
int assists = 0;
int steals = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter Game Stats"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Minutes Played"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                minutesPlayed = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Field Goals Attmpted"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                fieldGoalsAttempted = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Field Goals Made"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                fieldGoalsMade = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "3 Pointers Attempted"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                threePtAttempted = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "3 Pointers Made"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                threePtMade = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Free Throws Attempted"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                freeThrowsAttempted = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Free Throws Made"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                freeThrowsMade = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Offensive Rebounds"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                offensiveRebounds = int.parse(value);
              });
            }),
          TextField(
            decoration: const InputDecoration(labelText: "Defensive Rebounds"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                defensiveRebounds = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Assists"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                assists = int.parse(value);
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Steals"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                steals = int.parse(value);
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // widget.onStatsUpdated(starter, minutesPlayed, fieldGoalsAttempted, fieldGoalsMade, threePtAttempted, threePtMade, freeThrowsAttempted, freeThrowsMade, offensiveRebounds, defensiveRebounds, assists, steals);
                Navigator.pop(context);
              });
            },
            child: const Text("Update"),
            )
        ]),
        );
        
  }
  
}