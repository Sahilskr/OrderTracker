import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_tracker/util/validator.dart';

import '../util/custom_colors.dart';
import 'custom_form_field.dart';
import '../util/database.dart';

class AddCustomerForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode addressFocusNode;
  final FocusNode phoneFocusNode;

  const AddCustomerForm({Key? key,required this.nameFocusNode,
    required this.addressFocusNode,
    required this.phoneFocusNode}) : super(key: key);

  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _addCustomerFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addCustomerFormKey,
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
                  'Name',
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
                  label: 'Name',
                  hint: 'Enter your Name',
                ),
                SizedBox(height: 22.0),
                Text(
                  'Address',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    fontSize: 18.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CustomFormField(
                  maxLines: 8,
                  isLabelEnabled: false,
                  controller: _addressController,
                  focusNode: widget.addressFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'address',
                  hint: 'Enter your address',
                ),
                SizedBox(height: 22.0),
                Text(
                  'Phone no',
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
                  controller: _phoneController,
                  focusNode: widget.phoneFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Phone no',
                  hint: 'Enter your phone no',
                ),
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
                widget.addressFocusNode.unfocus();
                widget.phoneFocusNode.unfocus();


                if (_addCustomerFormKey.currentState!.validate()) {
                  setState(() {
                    _isProcessing = true;
                  });

                  await Database.addCustomer(
                    name: _nameController.text,
                    address: _addressController.text,
                    phone: _phoneController.text
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
                  'ADD CUSTOMER',
                  style: TextStyle(
                    fontSize: 24,
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
