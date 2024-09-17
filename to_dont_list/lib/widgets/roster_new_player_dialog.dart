import 'package:flutter/material.dart';

typedef RosterListAddedCallback = Function(
    String value, int number, TextEditingController textConroller);

class RosterDialog extends StatefulWidget {
  const RosterDialog({
    super.key,
    required this.onListAdded,
  });

  final RosterListAddedCallback onListAdded;

  @override
  State<RosterDialog> createState() {
    return _RosterDialogState();
  }
}

class _RosterDialogState extends State<RosterDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  int valueNum = -1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Player To Add'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          key: const Key("Player Name Text Field"),
          onChanged: (value) {
            setState(() {
              valueText = value;
            });
          },
          //TODO: find out what these controllers do and how i should fix this

          // controller: _inputController,
          decoration: const InputDecoration(hintText: "type player name"),
        ),
        TextField(
            key: const Key("Player Number Text Field"),
            onChanged: (number) {
              setState(() {
                valueNum = int.parse(number);
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "type player number"))
      ]),
      actions: <Widget>[
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(
                            valueText, valueNum, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
