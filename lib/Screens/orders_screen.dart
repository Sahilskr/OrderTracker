import 'package:flutter/material.dart';

import 'add_order_screen.dart';
import '../widgets/order_list.dart';

class OrderScreen extends StatefulWidget {
  final String documentId;
  const OrderScreen({Key? key,required this.documentId}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: Text("Orders"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddOrderScreen(docId:widget.documentId),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
            top: 8.0,
          ),
          child: OrderList(docId:widget.documentId),
        ),
      ),
    );
  }

}
