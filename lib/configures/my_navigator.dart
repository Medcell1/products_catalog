import 'package:flutter/cupertino.dart';
void pushLeftToRight(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return  nextPage;
      },
    ),
  );

}