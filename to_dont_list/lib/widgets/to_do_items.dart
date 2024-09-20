import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/word.dart';

typedef ToDoListChangedCallback = Function(Word item, bool completed);
typedef ToDoListRemovedCallback = Function(Word item);



class WordListItem extends StatefulWidget {
   WordListItem(
      {required this.word,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(word));

  final Word word;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State <WordListItem> createState() =>  WordListItemState();
}

class  WordListItemState extends State<WordListItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onListChanged(widget.word, widget.completed);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        //child: Text(word.abbrev()),
      ),
      title: Text(
        widget.word.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
