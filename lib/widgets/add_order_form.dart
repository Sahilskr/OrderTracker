import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_tracker/util/validator.dart';

import '../util/custom_colors.dart';
import 'custom_form_field.dart';
import '../util/database.dart';

class AddOrderForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode quantityFocusNode;
  final String docId;
  const AddOrderForm({Key? key,required this.nameFocusNode,
    required this.quantityFocusNode, required this.docId}) : super(key: key);

  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final _addOrderFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addOrderFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22.0),
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _nameController,
                  focusNode: widget.nameFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Product Name',
                  hint: 'Enter the Product Name',
                ),
                SizedBox(height: 22.0),
                Text(
                  'Quantity',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    fontSize: 18.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _quantityController,
                  focusNode: widget.quantityFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'quantity',
                  hint: 'Enter quantity',
                ),
                SizedBox(height: 28.0),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.firebaseOrange,
              ),
            ),
          )
              : Container(
            width: double.maxFinite,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CustomColors.firebaseOrange,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                widget.nameFocusNode.unfocus();
                widget.quantityFocusNode.unfocus();


                if (_addOrderFormKey.currentState!.validate()) {
                  setState(() {
                    _isProcessing = true;
                  });

                  await Database.addOrder(
                      name: _nameController.text,
                      quantity: _quantityController.text,
                      docId: widget.docId
                  ).onError((error, stackTrace)async{
                      Fluttertoast.showToast(
                          msg: error.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );


                  });

                  setState(() {
                    _isProcessing = false;
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  'ADD ORDER',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.firebaseGrey,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
