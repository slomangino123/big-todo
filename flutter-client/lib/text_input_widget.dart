import 'package:flutter/material.dart';


class TextInputWidget extends StatefulWidget {
  final Function(String) callback;
  const TextInputWidget(this.callback, {Key? key}) : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.message_outlined),
        labelText: 'Create Todo',
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          splashColor: Colors.purple,
          onPressed: click,
          tooltip: 'What to do?',
        )
      ),
    );
  }

  void click() {
    if (controller.text.isEmpty) {
      return;
    }

    // perform callback using controller text
    widget.callback(controller.text);

    // Clear text
    controller.clear();

    // Remove focus from the current widget's context
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}