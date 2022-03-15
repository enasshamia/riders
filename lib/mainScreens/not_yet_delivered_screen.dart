import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/widgets/progress_bar.dart';

import '../assitantMethodes/assistan_methods.dart';
import '../widgets/app_bar.dart';
import '../widgets/order_card.dart';

class NotYetDeliveredScreen extends StatefulWidget {
  const NotYetDeliveredScreen({Key? key}) : super(key: key);

  @override
  _NotYetDeliveredScreenState createState() => _NotYetDeliveredScreenState();
}

class _NotYetDeliveredScreenState extends State<NotYetDeliveredScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:MyappBar() ,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("orders").where("riderUid" , isEqualTo:sharedPreferences!.getString("uid")).where("status" ,isEqualTo: "delivering").snapshots(),
            builder: (c , snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (c, index) {
                    return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance.collection("items").where("itemID" , whereIn: separateOrdersIDs((snapshot.data!.docs[index].data()! as Map<String ,dynamic> ) ["productId"] )).get(),
                      builder:(c , snap){
                        return snap.hasData
                            ? OrderCard(
                          itemCount: snap.data!.docs.length,
                          data: snap.data!.docs,
                          orderId: snapshot.data!.docs[index].id,
                        )
                            : Center(child: circularProgress(),);
                      },
                    );
                  }
              )
                  :
              Center(child: circularProgress(),);
            }
        ),
      ),);
  }
}