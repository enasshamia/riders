import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/mainScreens/order_delivering_screen.dart';

import '../assitantMethodes/get_current_location.dart';
import '../map/map_utils.dart';

class OrderPickingScreen extends StatefulWidget {

  String?purchaserID;
  String?purchaserAddress;
  String?purchaserLat;
  String?purchaserLng;
  String?sellerID;
  String?orderID;

OrderPickingScreen({
    this.orderID,
    this.sellerID,
    this.purchaserAddress,
    this.purchaserID,
    this.purchaserLat,
    this.purchaserLng,
});
  @override
  _OrderPickingScreenState createState() => _OrderPickingScreenState();
}

class _OrderPickingScreenState extends State<OrderPickingScreen> {
  double? sellerLat , sellerLng;

  getSellerData() async
  {
     FirebaseFirestore.instance.collection("sellers").doc(widget.sellerID).get().then((DocumentSnapshot){
       sellerLat = DocumentSnapshot.data()!["let"];
       sellerLng = DocumentSnapshot.data()!["lng"];
     });
  }

  @override
  void initState() {
    super.initState();
    getSellerData();
  }

  confirmOrderPicked(getOrderId , sellerId , purchaserId ,purchaserAddress , purchaserLat , purchaserLng )
  {
      FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
        "status":"delivering",
        "address":completeAddress,
        "lat":position!.latitude,
        "lng":position!.longitude,
      });

      Navigator.push(context, MaterialPageRoute(builder: (c)=>  OrderDeliveringScreen(
          purchaserid: purchaserId,
          purchaserAddress: purchaserAddress,
          purchaserLat: purchaserLat,
          purchaserLng: purchaserLng,
          sellerId: sellerId,
          getOrderId: getOrderId,
      )));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/confirm1.png", 
          width: 350,),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              MapUtils.launchMapFromSourceToDestination(position!.latitude, position!.longitude, sellerLat, sellerLng);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/restaurant.png', width: 50,),
                const SizedBox(width: 7,),
                Column(
                  children: const [
                    SizedBox(height: 13,),
                    Text("Show Cafe/Resturant Location",style: TextStyle(fontFamily: "Signatra" , fontSize: 18,
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
                  UserLocation userLocation = UserLocation();
                  userLocation.getCurrentLocation();
                  confirmOrderPicked(widget.orderID,widget.sellerID,widget.purchaserID,widget.purchaserLat,widget.purchaserLng , widget.purchaserAddress);

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
                    child: Text("اخذت الطلبية "),
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
