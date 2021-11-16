import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _customerCollection = _firestore.collection('customers');

class Database {

  static Future<void> addCustomer({
    required String name,
    required String address,
    required String phone,

  }) async {
    DocumentReference documentReferencer =
    _customerCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "address": address,
      "phone":phone,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
    await documentReferencer
        .set(data).timeout(Duration(seconds: 5))
        .whenComplete(() {
      return Fluttertoast.showToast(
          msg: "Customer added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0
      );
    })        .catchError((e) => throw e);

  }

  static Future<void> addOrder({
    required String name,
    required String quantity,
    required String docId,

  }) async {
    DocumentReference documentReferencer =
    _customerCollection.doc(docId).collection("orders").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "quantity": quantity,
      "timestamp": DateTime.now().millisecondsSinceEpoch,

    };

    await documentReferencer
        .set(data).timeout(Duration(seconds: 5))
        .whenComplete(() {
          return Fluttertoast.showToast(
        msg: "Order added Successfully", toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        fontSize: 16.0
    );
        })
        .catchError((e) => throw e);
  }



  static Stream<QuerySnapshot> readCustomers() {
    CollectionReference customerCollection =
        _customerCollection;

    return customerCollection.orderBy("timestamp").snapshots();
  }
  static Stream<QuerySnapshot> readOrders({required String docID}) {
    CollectionReference ordersCollection =
    _customerCollection.doc(docID).collection("orders");

    return ordersCollection.orderBy("timestamp").snapshots();
  }


}