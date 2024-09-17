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
            Text(
              "Games Played: ${widget.player.gamesPlayed}",
              key: const Key("GamesPlayedText"),
            ),
            Text("Games Started: ${widget.player.gamesStarted}",
                key: const Key("GamesStartedText")),
            Text("Minutes Played: ${widget.player.minutesPlayed}",
                key: const Key("MinutesPlayedText"))
          ]),
        ),
        ListTile(
          title: const Text("Field Goals: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.fga}",
                  key: const Key("FGAText")),
              Text("Made: ${widget.player.fgm}", key: const Key("FGMText")),
              Text("Average %: ${widget.player.avg}",
                  key: const Key("FGAVGText"))
            ],
          ),
        ),
        ListTile(
          title: const Text("3 Pointers: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.threesA}",
                  key: const Key("3PTAText")),
              Text("Made: ${widget.player.threesM}",
                  key: const Key("3PTMText")),
              Text("Average %: ${widget.player.threesAvg}",
                  key: const Key("3PTAVGText"))
            ],
          ),
        ),
        ListTile(
          title: const Text("Free Throws: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attempted: ${widget.player.fta}",
                  key: const Key("FTAText")),
              Text("Made: ${widget.player.ftm}", key: const Key("FTMText")),
              Text("Average %: ${widget.player.ftAvg}",
                  key: const Key("FTAVGText"))
            ],
          ),
        ),
        ListTile(
          title: const Text("Rebounds: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Defensive: ${widget.player.dRebounds}",
                  key: const Key("DReboundsText")),
              Text("Offensive: ${widget.player.oRebounds}",
                  key: const Key("OReboundsText")),
              Text("Total: ${widget.player.totalRebounds}",
                  key: const Key("TotalReboundsText"))
            ],
          ),
        ),
        ListTile(
          title: const Text("Other: "),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Assists: ${widget.player.assists}",
                  key: const Key("AssistsText")),
              Text("Steals: ${widget.player.steals}",
                  key: const Key("StealsText"))
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
