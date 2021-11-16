import 'package:flutter/material.dart';
import 'package:order_tracker/util/custom_colors.dart';

class TpScreen extends StatelessWidget {
  const TpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Icon(Icons.search_off,size: 54,)),
            SizedBox(height: 10,),
            Center(child: Text("Nothing to show here!"))
          ],
        ),
      ),
    );
  }
}
