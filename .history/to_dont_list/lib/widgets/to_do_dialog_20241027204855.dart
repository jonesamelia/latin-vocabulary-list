import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value, String translatione, TextEditingController textController, TextEditingController trController);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  String translationText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog( 
      title: const Text('Word To Add'),
      content: Column(mainAxisSize: MainAxisSize.min, children:[
        TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _wordController,
        decoration: const InputDecoration(hintText: "type Latin word here"),
      ), 
      TextField(
        onChanged: (translate) {
          setState(() {
            translationText = translate;
          });
        },
        controller: _translationController,
        decoration: const InputDecoration(hintText: "type translation here"),
      ),
      ] ),
      actions: <Widget>[
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

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _wordController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(valueText, translationText, _translationController, _wordController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
