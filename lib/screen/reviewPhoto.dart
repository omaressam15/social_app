import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ReviewPhoto extends StatelessWidget {

  final String photo;
  final int index;


  const ReviewPhoto({Key key,this.photo,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: index.toString(),

          child: Center(
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(
                photo,
              ),

        ),
          ),
        ),
    )
    );
  }
}
