import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/add_customer_form.dart';

class AddCustomerScreen extends StatelessWidget {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _addressFocusNode.unfocus();
        _phoneFocusNode.unfocus();

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
            child: AddCustomerForm(
              nameFocusNode: _nameFocusNode,
              addressFocusNode: _addressFocusNode,
              phoneFocusNode:_phoneFocusNode,
            ),
          ),
        ),
      ),
    );
  }

}
