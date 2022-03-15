import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/assitantMethodes/get_current_location.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/mainScreens/order_picking_screen.dart';
import '../mainScreens/home_screen.dart';
import '../models/user.dart';

class ShipmentDesgin extends StatelessWidget {

   final User? model ;
   final String? city;
   final String? orderStatus;
   final String? lat;
   final String? lng;
   final String? orderId ;
   final String? sellerId ;
   final String? orderBy ;


   ShipmentDesgin({this.model , this.city ,this.orderStatus,  this.lat,  this.lng , this.orderId , this.sellerId , this.orderBy});

   confirmOrder(BuildContext context,String orderID , String sellerID , String purchaserID){
     
     FirebaseFirestore.instance.collection("orders").doc(orderID).update({

       "riderUid": sharedPreferences!.getString("uid"),
       "riderName": sharedPreferences!.getString("name"),
       "status": "picking",
       "lat": position!.altitude,
       "lng": position!.longitude,
       "addressID":completeAddress,
     });
      Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderPickingScreen(

          purchaserID: purchaserID ,
          purchaserAddress: city,
          purchaserLat: lat,
          purchaserLng: lng,
          sellerID: sellerID,
          orderID:orderID,


      )));
   }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('ـفاصيل الطلب'),
        const SizedBox(height: 20.0,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90 , vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children:[
                  Text(model!.userrName!),
                  Text("الأسم"),

                ]
              ),
              TableRow(
                children:[
                  Text(model!.phone!),
                  Text("رقم الهاتف"),

                ]
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0,),
        Text(city!  , textAlign: TextAlign.justify,),
        orderStatus == "ended" ? Container() : Padding(padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                UserLocation userLocation = UserLocation();
                userLocation.getCurrentLocation();
                
                confirmOrder(context, orderId!, sellerId!, orderBy!,);
                
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
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text("take order"),
                ),
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
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
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text("go back"),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
