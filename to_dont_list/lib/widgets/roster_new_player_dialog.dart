import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef RosterListAddedCallback = Function(
    String value, int number, TextEditingController textConroller, File? imagec);

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
  final ImagePicker picker = ImagePicker();
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  int valueNum = -1;
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
  final imageTemp = File(image.path);
  setState(() => this.image = imageTemp);
    } catch (e){
      print('fail');
    }
  }

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
            decoration: const InputDecoration(hintText: "type player number")),
        ElevatedButton(onPressed: (){
          pickImage();
        }, child: const Text('Add Image')),

      // https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74

        SizedBox(height: 20,),
        image != null ? Image.file(image!): Text("No image selected")
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
                            valueText, valueNum, _inputController, image);
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
