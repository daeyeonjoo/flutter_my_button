import 'package:fluter04/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _buttonText = 'This is like CupertinoButton';

  void onPressed() {
    print('OKOK');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              print('oh?');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyButton(
                    child: Text(_buttonText, textDirection: TextDirection.ltr))
              ],
            )));
    // child: Container(
    //     color: Colors.amber,
    //     width: 100,
    //     height: 50,
    //     alignment: Alignment.center,
    //     child: Text('a', textDirection: TextDirection.ltr))));
  }
}
