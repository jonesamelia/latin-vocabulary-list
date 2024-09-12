

import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/roster_edit_stats_dialog.dart';

final List statCategoriesList = [
  "Playing Time",
  "Field Goals",
  "3 Pointers",
  "Free Throws",
  "Rebounds",
  "Other"
];
class RosterStatsView extends StatelessWidget{
  final Player player;

  const RosterStatsView({super.key, required this.player});



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
      ),
      body: ListView(
        
        children: [
          ListTile (
            title: const Text("Playing Time: "),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Games Played: ${player.gamesPlayed}"),
                Text("Games Started: ${player.gamesStarted}"),
                Text("Minutes Played: ${player.minutesPlayed}")
              ]
            ),
            
            ), 
            ListTile(
              title: const Text("Field Goals: "),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attempted: ${player.fga}"),
                  Text("Made: ${player.fgm}"),
                  Text("Average %: ${player.avg}")
                ],
              ),
            ),
            ListTile(
              title: const Text("3 Pointers: "),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attempted: ${player.threesA}"),
                  Text("Made: ${player.threesM}"),
                  Text("Average %: ${player.threesAvg}")
                ],
              ),
            ),
            ListTile(
              title: const Text("Free Throws: "),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attempted: ${player.fta}"),
                  Text("Made: ${player.ftm}"),
                  Text("Average %: ${player.ftAvg}")
                ],
              ),
            ),
            ListTile(
              title: const Text("Rebounds: "),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Defensive: ${player.dRebounds}"),
                  Text("Offensive: ${player.oRebounds}"),
                  Text("Total: ${player.totalRebounds}")
                ],
              ),
            ),
            ListTile(
              title: const Text("Other: "),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Assits: ${player.assists}"),
                  Text("Steals: ${player.steals}"),
                ],
              ),
            ),

            //TODO: this is repetitive. Make a new widget and map it to this I guess. kinda like main and roster_players. But each list 
            //would be slightly different. The level of abstraction is possible, but for an application that is due in a week, it is too time intensive
        ]
      ),
      floatingActionButton: FloatingActionButton(
            tooltip: "Input New Game Stats",
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return RosterEditStatsDialog();
                  }
                );
            }
        ),
    );
  }



}