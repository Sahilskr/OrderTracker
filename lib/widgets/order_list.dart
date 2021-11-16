import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/Screens/tp_screen.dart';

import '../util/custom_colors.dart';
import '../util/database.dart';

class OrderList extends StatelessWidget {
  final String docId;
  const OrderList({Key? key,required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readOrders(docID: docId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderInfo = snapshot.data!.docs[index].data()! as Map;
              String docID = snapshot.data!.docs[index].id;
              String name = orderInfo['name'];
              String quantity = orderInfo['quantity'];


              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TpScreen(
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text("Quantity: "+quantity),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.firebaseOrange,
            ),
          ),
        );
      },
    );
  }

}
