// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/roster_players.dart';
import 'package:to_dont_list/widgets/roster_new_player_dialog.dart';

class RosterList extends StatefulWidget {
  const RosterList({super.key});

  @override
  State createState() {
    return _RosterListState();
  }
}

class _RosterListState extends State<RosterList> {
  final List<Player> players = [
    Player(name: "Colten Berry", number: 35),
    Player(name: "Beau Kronenberger", number: 4),
    Player(name: "Sky Tschurr", number: 5),
    Player(name: "Braden Weaver", number: 10),
    Player(name: "Carson Bower", number: 11),
    Player(name: "Caleb Squires", number: 12),
    Player(name: "Houston Likens", number: 14),
    Player(name: "Colin Scifres", number: 15),
    Player(name: "Darvis Raspberry", number: 20),
    Player(name: "Zach Nolan", number: 24),
    Player(name: "Colin Wade", number: 30),
    Player(name: "Drew Mayo", number: 32),
    Player(name: "Luke Patton", number: 34),
    Player(name: "Tyler Deithloff", number: 44)

  ];
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

  void _handleNewItem(String playerText, int playerNumber, TextEditingController textController, File? img) {
    setState(() {
      print("Adding new item");
      Player player = Player(name: playerText, number: playerNumber, image: img);
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
            tooltip: "Add a new player",
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
