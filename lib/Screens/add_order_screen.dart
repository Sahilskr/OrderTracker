import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/add_order_form.dart';


class AddOrderScreen extends StatelessWidget {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final String docId;

   AddOrderScreen({Key? key,required this.docId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _quantityFocusNode.unfocus();

      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text("Order Tracker"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddOrderForm(
              nameFocusNode: _nameFocusNode,
              quantityFocusNode: _quantityFocusNode,
              docId:docId
            ),
          ),
        ),
      ),
    );
  }

}
