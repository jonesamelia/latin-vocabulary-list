import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Word.dart';

typedef ToDoListChangedCallback = Function(Word item, bool completed);
typedef ToDoListRemovedCallback = Function(Word item);

class ToDoListItem extends StatelessWidget {
  ToDoListItem(
      {required this.word,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(word));

  final Word word;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(word, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(word);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        //child: Text(word.abbrev()),
      ),
      title: Text(
        word.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
