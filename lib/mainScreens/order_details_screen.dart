import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import '../widgets/progress_bar.dart';
import '../widgets/shipment_address_desgin.dart';
import '../widgets/status_banner.dart';

class OrderDetailScreen extends StatefulWidget {

  final String? orderId ;
  OrderDetailScreen({this.orderId });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  String orderStatus = "" ;
  String address = "" ;
  String sellerId = "";
  String orderBy = "" ;
  String? lng , lat ;

  getOrderInfo()
  {
      FirebaseFirestore.instance.collection("orders").doc(widget.orderId!).get().then((DocumentSnapshot)
     {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderBy = DocumentSnapshot.data()!["orderBY"].toString();
      sellerId = DocumentSnapshot.data()!["sellerUid"].toString();
    }
    );
    }

  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("orders").doc(widget.orderId!).get(),
          builder: (c,snapshot){
              Map? dataMap;
              if(snapshot.hasData){
               dataMap = snapshot.data!.data()! as Map<String , dynamic>;
               orderStatus = dataMap["status"].toString();
               address = dataMap["addressID"].toString();
               lat = dataMap["lat"].toString() ;
               lng = dataMap["lng"].toString();
              }
              return snapshot.hasData ? Container(
                child: Column(
                  children: [
                      StatusBanner(
                        status: dataMap!["isSuccess"],
                        orderStatus: orderStatus ,
                      ),
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text( "\$ " + "السعر الكلي" + dataMap["totalAmount"].toString(),
                        style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text( "رقم الوصل : " + widget.orderId!,
                        style: const TextStyle(fontSize: 15 , ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(DateFormat("dd MMMM , yyyy - hh:mm aa").format(DateTime.fromMicrosecondsSinceEpoch(int.parse(dataMap["orderId"]))) + " : تم الطلب في ",
                        style: const TextStyle(fontSize: 15 , ),),
                      ),
                    ),
                    const Divider(thickness: 4,),
                    orderStatus == "ended"
                        ? Image.asset("images/success.jpg")
                        : Image.asset("images/confirm_pick.png"),
                    const Divider(thickness: 4,),
                    FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance.collection("users").doc(orderBy).get(),
                        builder: (c , snapshot){
                          return snapshot.hasData
                              ?ShipmentDesgin(
                            model: User.fromJson(
                              snapshot.data!.data()! as Map<String ,dynamic>,
                            ) ,
                            city:   address,
                            orderStatus:orderStatus,
                            lat:lat,
                            lng:lng,
                            orderId:widget.orderId,
                            sellerId:sellerId,
                            orderBy:orderBy,

                          )
                              :Center(child: circularProgress(),);
                        }
                    ),


                  ],
                ),
              ) : Center(child: circularProgress(),);
          }
        ),
      ),
    );
  }
}
