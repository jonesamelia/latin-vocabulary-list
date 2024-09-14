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

class RosterStatsView extends StatefulWidget {
  final Player player;
  const RosterStatsView({super.key, required this.player});

  @override
  State<StatefulWidget> createState() {
    return RosterStatsViewState();
  }
}

class RosterStatsViewState extends State<RosterStatsView> {
  void handleNewGame(
      bool starter,
      int minutesPlayed,
      int fieldGoalsAttempted,
      int fieldGoalsMade,
      int threePtAttempted,
      int threePtMade,
      int freeThrowsAttempted,
      int freeThrowsMade,
      int offensiveRebounds,
      int defensiveRebounds,
      int assists,
      int steals) {
    setState(() {
      widget.player.gamesPlayed += 1;
      if (starter) {
        widget.player.gamesStarted += 1;
      }
      widget.player.minutesPlayed += minutesPlayed;

      widget.player.fga += fieldGoalsAttempted;
      widget.player.fgm += fieldGoalsMade;

      widget.player.threesA += threePtAttempted;
      widget.player.threesM += threePtMade;

      widget.player.fta += freeThrowsAttempted;
      widget.player.ftm += freeThrowsMade;

      widget.player.oRebounds += offensiveRebounds;
      widget.player.dRebounds += defensiveRebounds;

      widget.player.assists += assists;
      widget.player.steals += steals;

      widget.player.calculateAvg();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
      ),
      body: ListView(children: [
        ListTile(
          title: const Text("Playing Time: "),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Games Played: ${widget.player.gamesPlayed}"),
            Text("Games Started: ${widget.player.gamesStarted}"),
            Text("Minutes Played: ${widget.player.minutesPlayed}")
          ]),
        ),
        ListTile(
          title: const Text("Field Goals: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.fga}"),
              Text("Made: ${widget.player.fgm}"),
              Text("Average %: ${widget.player.avg}")
            ],
          ),
        ),
        ListTile(
          title: const Text("3 Pointers: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.threesA}"),
              Text("Made: ${widget.player.threesM}"),
              Text("Average %: ${widget.player.threesAvg}")
            ],
          ),
        ),
        ListTile(
          title: const Text("Free Throws: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.fta}"),
              Text("Made: ${widget.player.ftm}"),
              Text("Average %: ${widget.player.ftAvg}")
            ],
          ),
        ),
        ListTile(
          title: const Text("Rebounds: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Defensive: ${widget.player.dRebounds}"),
              Text("Offensive: ${widget.player.oRebounds}"),
              Text("Total: ${widget.player.totalRebounds}")
            ],
          ),
        ),
        ListTile(
          title: const Text("Other: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Assits: ${widget.player.assists}"),
              Text("Steals: ${widget.player.steals}")
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return RosterEditStatsDialog(
                    onGameAdded: handleNewGame,
                  );
                });
          }),
    );
  }
}
