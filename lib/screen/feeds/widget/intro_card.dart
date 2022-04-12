import 'package:flutter/material.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: Alignment.bottomRight,
        children:  [
          const Image(
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://image.freepik.com/free-photo/close-up-hands-holding-mugs_23-2149180994.jpg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Communicate with your friends',
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white,fontSize: 16),),
          ),
        ],
      ),

    );
  }
}
