// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/roster_players.dart';

void main() {
  // test('Item abbreviation should be first letter', () {
  //   const item = Item(name: "add more todos");
  //   expect(item.abbrev(), "a");
  // });

  // // Yes, you really need the MaterialApp and Scaffold
  // testWidgets('ToDoListItem has a text', (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //           body: RosterListPlayer(
  //               item: const Item(name: "test"),
  //               completed: true,
  //               onListChanged: (Item item, bool completed) {},
  //               onDeleteItem: (Item item) {}))));
  //   final textFinder = find.text('test');

  //   // Use the `findsOneWidget` matcher provided by flutter_test to verify
  //   // that the Text widgets appear exactly once in the widget tree.
  //   expect(textFinder, findsOneWidget);
  // });

  // testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
  //     (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //           body: RosterListPlayer(
  //               item: const Item(name: "test"),
  //               completed: true,
  //               onListChanged: (Item item, bool completed) {},
  //               onDeleteItem: (Item item) {}))));
  //   final abbvFinder = find.text('t');
  //   final avatarFinder = find.byType(CircleAvatar);

  //   CircleAvatar circ = tester.firstWidget(avatarFinder);
  //   Text ctext = circ.child as Text;

  //   // Use the `findsOneWidget` matcher provided by flutter_test to verify
  //   // that the Text widgets appear exactly once in the widget tree.
  //   expect(abbvFinder, findsOneWidget);
  //   expect(circ.backgroundColor, Colors.black54);
  //   expect(ctext.data, "t");
  // });

  // testWidgets('Default ToDoList has one item', (tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: ToDoList()));

  //   final listItemFinder = find.byType(RosterListPlayer);

  //   expect(listItemFinder, findsOneWidget);
  // });

  // testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: ToDoList()));

  //   expect(find.byType(TextField), findsNothing);

  //   await tester.tap(find.byType(FloatingActionButton));
  //   await tester.pump(); // Pump after every action to rebuild the widgets
  //   expect(find.text("hi"), findsNothing);

  //   await tester.enterText(find.byType(TextField), 'hi');
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   await tester.tap(find.byKey(const Key("OKButton")));
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   final listItemFinder = find.byType(RosterListPlayer);

  //   expect(listItemFinder, findsNWidgets(2));
  // });

  // // One to test the tap and press actions on the items?

  //Player Tests:
  test("Player Rounding rounds to third decimal", () {
    Player player = Player(name: "John Johnson", number: 20);

    expect(player.roundTwoDecimals(12.23416), 12.234);
  });

  test("Player calculate average calculates the average", () {
    Player player = Player(name: "John", number: 20);
    player.fga = 119;
    player.fgm = 78;
    player.threesA = 81;
    player.threesM = 39;
    player.fta = 78;
    player.ftm = 67;
    player.dRebounds = 22;
    player.oRebounds = 13;

    player.calculateAvg();

    expect(player.avg, 65.5);
    expect(player.ftAvg, 85.9);
    expect(player.threesAvg, 48.1);
    expect(player.totalRebounds, 35);
  });

  //RosterListPlayer Tests
  testWidgets("RosterListPlayer has a name, number, and FG%", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: RosterListPlayer(
                player: Player(name: "name", number: 20),
                onListChanged: (Player player) {},
                onDeleteItem: (Player player) {}))));
    final textFinder = find.text('name');
    expect(textFinder, findsOneWidget);
  });
}
