import 'package:flutter/material.dart';

class Reload extends StatefulWidget {
  final Future Function() reloadCallback;
  const Reload(this.reloadCallback, { Key? key }) : super(key: key);

  @override
  State<Reload> createState() => _ReloadState();
}

class _ReloadState extends State<Reload> {
  reload() async {
    // perform callback using todo id
    await widget.reloadCallback();

    // Remove focus from the current widget's context
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
          onTap: reload,
          child: const Icon(Icons.refresh)
        );
  }
}