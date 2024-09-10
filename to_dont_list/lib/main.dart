// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class RosterList extends StatefulWidget {
  const RosterList({super.key});

  @override
  State createState() {
    return _RosterListState();
  }
}

class _RosterListState extends State<RosterList> {
  final List<Player> players = [Player(name: "Colten Berry", number: 35)];
  // final _itemSet = <Item>{};

  void _handleListChanged(Player player) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      print("Making Undone");
      // _itemSet.remove(item);
      players.insert(players.length, player);
    });
  }

  void _handleDeleteItem(Player player) {
    setState(() {
      print("Deleting item");
      players.remove(player);
    });
  }

  void _handleNewItem(String playerText, int playerNumber, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Player player = Player(name: playerText, number: playerNumber);
      players.insert(0, player);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Roster List'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: players.map((player) {
            return RosterListPlayer(
              player: player,
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return RosterDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: RosterList(),
  ));
}
