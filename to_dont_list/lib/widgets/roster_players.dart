import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/roster_stats_view.dart';

typedef ToDoListChangedCallback = Function(Player player);
typedef ToDoListRemovedCallback = Function(Player player);

enum SampleItem { viewPlayer, editPlayer, deletePlayer }

class RosterListPlayer extends StatelessWidget {
  RosterListPlayer(
      {required this.player,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(player));

  final Player player;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.black,
    );
  }

  CircleAvatar _getCircle(BuildContext context){
    if(player.image == null){
      return CircleAvatar(backgroundImage: Image.asset('assets/Basketball.png').image, backgroundColor: Colors.red);
    } else{
      return CircleAvatar(backgroundImage: Image.file(File(player.image!.path)).image,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //TODO: Later i want a pop up displaying all the stats, but right now this was causing problems

      // onTap: () => onListChanged(player),
      // onLongPress: () => onDeleteItem(player),
      leading: _getCircle(context), /*CircleAvatar(
        backgroundImage: Image.file(File(player.image!.path)).image,
        // backgroundImage: AssetImage('assets/Basketball icon.png'), //TODO: this isn't working. idk why
        backgroundColor: Colors.red,
      ),*/
      title: Text(
        player.name,
        style: _getTextStyle(context),
      ),
      subtitle: Row(
        children: [
          Text("Number: ${player.number}"),

          //Vertical divider isn't quite what I want, but it works for now
          const VerticalDivider(
            width: 5,
          ),
          Text("Field Goal %: ${player.avg}")
        ],
      ),
      trailing: PopupMenuButton(
        key: const Key("PlayerPopupMenuButton"),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          PopupMenuItem(
            key: const Key("ViewPlayerPopupMenuItem"),
            value: SampleItem.viewPlayer,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RosterStatsView(player: player))),
            child: const Text('View Stats'),
          ),
          PopupMenuItem(
            key: const Key("DeletePlayerPopupMenuItem"),
            value: SampleItem
                .deletePlayer, //is value even needed? the flutter documentation had it so i put it in
            onTap: () => onDeleteItem(player),
            child: const Text('Delete Player'),
          )
        ],
      ),
    );
  }
}
