import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/splashScreen/splash_screen.dart';

import '../assitantMethodes/get_current_location.dart';
import '../global/global.dart';
import '../map/map_utils.dart';

class OrderDeliveringScreen extends StatefulWidget {

  String?purchaserid;
  String?purchaserAddress;
  String?purchaserLat;
  String?purchaserLng;
  String?sellerId;
  String?getOrderId;

  OrderDeliveringScreen({this.purchaserAddress,this.getOrderId,this.sellerId,this.purchaserLng,this.purchaserLat,this.purchaserid});

  @override
  _OrderDeliveringScreenState createState() => _OrderDeliveringScreenState();
}

class _OrderDeliveringScreenState extends State<OrderDeliveringScreen> {

  String orderTotalAmount = "" ;

  confirmOrderDelivered(getOrderId , sellerId , purchaserId ,purchaserAddress , purchaserLat , purchaserLng )
  {

    String newRiderTotalEarningAmount = (double.parse(previousRiderEarnings) + (double.parse(perOrderAmount))).toString();

    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
      "status":"ended",
      "address":completeAddress,
      "lat":position!.latitude,
      "lng":position!.longitude,
      "earnings": perOrderAmount ,
    }).then((value){

      FirebaseFirestore.instance.collection("riders").doc(sharedPreferences!.getString("uid")).update({
        "earnings":newRiderTotalEarningAmount, //pay per order delivery
      });
    }).then((value) {
      FirebaseFirestore.instance.collection("sellers")
          .doc(widget.sellerId)
          .update({
        "earnings": (double.parse(orderTotalAmount) +(double.parse(previousEarnings))).toString(), // total earnings for seller

      });
    }).then((value){

      FirebaseFirestore.instance.collection("users")
          .doc(purchaserId).collection("orders").doc(getOrderId)
          .update({
        "status": "ended",
        "riderUid": sharedPreferences!.getString("uid"),
      });
      });

    Navigator.push(context, MaterialPageRoute(builder: (c)=>  MySplashScreen()));
  }

  getOrderTotalAmount(){
    FirebaseFirestore.instance.collection("orders").doc(widget.getOrderId).get().then((snap){
      orderTotalAmount = snap.data()!["totalAmount"].toString();
      widget.sellerId = snap.data()!["sellerUid"].toString();

    }).then((value){
      getSellerData();
    });
  }

  getSellerData(){
    FirebaseFirestore.instance.collection("sellers").doc(widget.sellerId).get().then((snap){
      previousEarnings = snap.data()!["earnings"].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    UserLocation userLocation = UserLocation();
    userLocation.getCurrentLocation();

    getOrderTotalAmount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/confirm2.png",
           ),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              MapUtils.launchMapFromSourceToDestination(position!.latitude, position!.longitude, widget.purchaserLat, widget.purchaserLng);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/restaurant.png', width: 50,),
                const SizedBox(width: 7,),
                Column(
                  children: const [
                    SizedBox(height: 13,),
                    Text("Show Delivery Drop-off Location",style: TextStyle(fontFamily: "Signatra" , fontSize: 18,
                        letterSpacing: 2),),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 35,),

          Padding(padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: ()
                {

                  //rider location
                  UserLocation userLocation = UserLocation();
                  userLocation.getCurrentLocation();
                  confirmOrderDelivered(widget.getOrderId,widget.sellerId,widget.purchaserid,widget.purchaserLat,widget.purchaserLng , widget.purchaserAddress);

                },
                child: Container(
                  decoration:  const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.cyan,
                      Colors.amber,
                    ],
                      begin: FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0 , 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text("اوصلت الطلب  "),
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
