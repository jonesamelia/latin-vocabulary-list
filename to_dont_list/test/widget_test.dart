// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:ffi' hide Size;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/main.dart';

import 'package:to_dont_list/objects/player.dart';
import 'package:to_dont_list/widgets/roster_players.dart';
import 'package:to_dont_list/widgets/roster_stats_view.dart';

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
  testWidgets("RosterListPlayer has a name", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: RosterListPlayer(
                player: Player(name: "name", number: 20),
                onListChanged: (Player player) {},
                onDeleteItem: (Player player) {}))));
    final textFinder = find.text('name');
    expect(textFinder, findsOne);
  });

  //rosterDialog - for a new player.
  testWidgets("Clicking and typing adds player", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RosterList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text("Joe Johnson"), findsNothing);

    await tester.enterText(
        find.byKey(const Key("Player Name Text Field")), "Joe Johnson");
    await tester.enterText(
        find.byKey(const Key("Player Number Text Field")), "20");
    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("Joe Johnson"), findsOneWidget);
    expect(find.text("20"), findsOneWidget);
  });

  //rosterStatsView
  //this won't run right because I guess it is not switching to the RosterStatsView, even though it should.
  //I have to make a similar test to ensure delete works
  testWidgets("Clicking View brings up View Screen", (tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(1920 * dpi, 1080 * dpi);

    await tester.pumpWidget(const MaterialApp(home: RosterList()));

    await tester.tap(find.byKey(const Key("PlayerPopupMenuButton")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('ViewPlayerPopupMenuItem')));
    await tester.pumpAndSettle();

    final screenFinder = find.byType(RosterStatsView);
    expect(screenFinder, findsOneWidget);
  });

  //similarly, tapping these menu buttons seems to do nothing. are the menu buttons offscreen too?
  testWidgets("Clicking Delete deletes the player", (tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(1920 * dpi, 1080 * dpi);

    await tester.pumpWidget(const MaterialApp(home: RosterList()));

    await tester.tap(find.byKey(const Key("PlayerPopupMenuButton")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("DeletePlayerPopupMenuItem")));
    await tester.pumpAndSettle();
    final wFinder = find.byType(RosterListPlayer);
    expect(wFinder, findsNWidgets(13));
    expect(find.text("Colten Berry"), findsNothing);
  });

  //rosterEditStatsDialog

  testWidgets("All fields exist", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: RosterStatsView(
      player: Player(name: "John Johnson", number: 20),
    )));

    expect(find.byKey(const Key("GamesPlayedText")), findsOneWidget);
    expect(find.byKey(const Key("GamesStartedText")), findsOneWidget);
    expect(find.byKey(const Key("MinutesPlayedText")), findsOneWidget);

    expect(find.byKey(const Key("FGAText")), findsOneWidget);
    expect(find.byKey(const Key("FGMText")), findsOneWidget);
    expect(find.byKey(const Key("FGAVGText")), findsOneWidget);

    expect(find.byKey(const Key("3PTAText")), findsOneWidget);
    expect(find.byKey(const Key("3PTMText")), findsOneWidget);
    expect(find.byKey(const Key("3PTAVGText")), findsOneWidget);

    expect(find.byKey(const Key("FTAText")), findsOneWidget);
    expect(find.byKey(const Key("FTMText")), findsOneWidget);
    expect(find.byKey(const Key("FTAVGText")), findsOneWidget);

    expect(find.byKey(const Key("DReboundsText")), findsOneWidget);
    expect(find.byKey(const Key("OReboundsText")), findsOneWidget);
    expect(find.byKey(const Key("TotalReboundsText")), findsOneWidget);

    expect(find.byKey(const Key("AssistsText")), findsOneWidget);
    expect(find.byKey(const Key("StealsText")), findsOneWidget);
  });

//how to make testing emulator large enough. prof thinks testing emulator is not large enough
  testWidgets("Clicking and typing updates Fields", (tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(1920 * dpi, 1080 * dpi);
    await tester.pumpWidget(MaterialApp(
      home: RosterStatsView(player: Player(name: "Joe Johnson", number: 20)),
    ));

    var textFinder = find.text("Games Played: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Games Started: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Minutes Played: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Attempted: 0");
    expect(textFinder, findsNWidgets(3));

    textFinder = find.text("Made: 0");
    expect(textFinder, findsNWidgets(3));

    //starts off NA
    // textFinder = find.text("Average %: 0");
    // expect(textFinder, findsNWidgets(3));

    textFinder = find.text("Defensive: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Offensive: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Total: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Assists: 0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Steals: 0");
    expect(textFinder, findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    await tester.enterText(
        find.byKey(const Key("MinutesPlayedTextField")), "30");
    await tester.pump();
    await tester.enterText(find.byKey(const Key("FGATextField")), "8");
    await tester.pump();
    await tester.enterText(find.byKey(const Key("FGMTextField")), "5");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("3PTATextField")), "2");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("3PTMTextField")), "2");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("FTATextField")), "7");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("FTMTextField")), "3");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("OReboundsTextField")), "4");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("DReboundsTextField")), "7");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("AssistsTextField")), "3");
    await tester.pump();

    await tester.enterText(find.byKey(const Key("StealsTextField")), "1");
    await tester.pump();

    expect(find.text("8"), findsOne);

    await tester
        .ensureVisible(find.byKey(const Key("UpdateStatsElevatedButton")));
    await tester.tap(find.byKey(const Key("UpdateStatsElevatedButton")));
    await tester.pumpAndSettle();

    // textFinder = find.text("Games Played: 1");
    // expect(textFinder, findsOneWidget);

    // textFinder = find.text("Games Started: 1");
    // expect(textFinder, findsOneWidget);

    textFinder = find.text("Minutes Played: 30");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Attempted: 8");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Attempted: 2");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Attempted: 7");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Made: 5");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Made: 2");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Made: 3");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Average %: 62.5");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Average %: 100.0");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Average %: 42.9");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Defensive: 7");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Offensive: 4");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Total: 11");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Assists: 3");
    expect(textFinder, findsOneWidget);

    textFinder = find.text("Steals: 1");
    expect(textFinder, findsOneWidget);
  });
}
