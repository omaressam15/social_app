import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ChatScreen',style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}
