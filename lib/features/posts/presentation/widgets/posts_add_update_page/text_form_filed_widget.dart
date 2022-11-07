import 'package:flutter/material.dart';

class TextFormFiledWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multiLine;
  const TextFormFiledWidget({Key? key, required this.controller, required this.name, required this.multiLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val!.isEmpty) {
            return "$name Can't be empty";
          }
          return null;
        },
        minLines: multiLine? 6 : 1,
        maxLines: multiLine? 6 : 1,
        decoration:  InputDecoration(
          hintText: name,
        ),
      ),
    );
  }
}
