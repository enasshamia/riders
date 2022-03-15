import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/authenctication/auth_screen.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/mainScreens/earnings_screen.dart';
import 'package:lhad_albiet_riders/mainScreens/history_screen.dart';
import 'package:lhad_albiet_riders/mainScreens/not_yet_delivered_screen.dart';
import 'package:lhad_albiet_riders/mainScreens/order_in_progress_screen.dart';
import 'package:lhad_albiet_riders/mainScreens/orders_screen.dart';

import '../assitantMethodes/get_current_location.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Card makeDashboardItem(String title , IconData iconData , int index){
    return Card(
      elevation: 2,
      margin:const EdgeInsets.all(8),
         child: Container(
         decoration: index == 0 || index == 3 || index == 4
             ?
         const BoxDecoration(
          gradient: LinearGradient(colors: [
          Colors.amber,
          Colors.cyan,
          ],
          begin: FractionalOffset(0.0, 0.0),
      end:  FractionalOffset(1.0, 0.0),
      stops: [0.0 , 1.0],
      tileMode: TileMode.clamp,
    ),
    )
             :
         const BoxDecoration(
         gradient: LinearGradient(colors: [
             Colors.redAccent,
             Colors.amber,
             ],
             begin: FractionalOffset(0.0, 0.0),
      end:  FractionalOffset(1.0, 0.0),
      stops: [0.0 , 1.0],
      tileMode: TileMode.clamp,
    ),
    ) ,
           child: InkWell(
             onTap: (){
               if(index==0)
                 {
                   Navigator.push(context, MaterialPageRoute(builder: (c)=> const OrdersScreen()));
                   //new orders
                 }
               if(index==1)
               {
                 Navigator.push(context, MaterialPageRoute(builder: (c)=> const OrderInProgress()));

                 //parcels in progress
               }
               if(index==2)
               {
                 Navigator.push(context, MaterialPageRoute(builder: (c)=> const NotYetDeliveredScreen()));
               }
               if(index==3)
               {
                 Navigator.push(context, MaterialPageRoute(builder: (c)=> const HistoryScreen()));
               }
               if(index==4)
               {
                 //total earning
                 Navigator.push(context, MaterialPageRoute(builder: (c)=> const EarningsScreen()));

               }
               if(index==5)
               {
                 //logout
                 firebaseAuth.signOut().then((value){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                 });
               }
             },
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               mainAxisSize: MainAxisSize.min ,
               verticalDirection: VerticalDirection.down,
               children: [
                 const SizedBox(height: 50.0,),
                 Center(child: Icon(
                     iconData,
                   size: 40,
                     color: Colors.black,
                 ),),
                 const SizedBox(height: 10.0,),
                 Center(
                   child: Text(
                     title,
                     style: const TextStyle(
                       fontSize: 16,
                       color: Colors.black,
                     ),
                   ),
                 ),
               ],
             ),
           ) ,
    ),
    );
  }


 @override
  void initState(){
    super.initState();
   UserLocation userLocation = UserLocation();
   userLocation.getCurrentLocation();
   getPerOrderDeliveryAmoun();
    getRiderPreviousEarnings();

 }

 getRiderPreviousEarnings(){
   FirebaseFirestore.instance.collection("riders").doc(sharedPreferences!.getString("uid")).get().then((snap){

     previousRiderEarnings = snap.data()!["earnings"].toString();

   });

       }

 getPerOrderDeliveryAmoun(){
    FirebaseFirestore.instance.collection("perDelivery").doc("fa789").get().then((snap)
        {
          perOrderAmount =  snap.data()!["amount"].toString();
        }
    );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50 , horizontal: 1),
        child: GridView.count(
            crossAxisCount: 2,
                padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("طلبات جديدة", Icons.assignment, 0),
            makeDashboardItem("طلبات قيد التحضير", Icons.airport_shuttle, 1),
            makeDashboardItem("لم يصل حتى الان", Icons.location_history, 2),
            makeDashboardItem("قائمتي", Icons.done_all, 3),
            makeDashboardItem("مدخولاتي", Icons.monetization_on, 4),
            makeDashboardItem("تسجيل الخروج", Icons.logout, 5),
          ],
        ),
      ),

    );
  }
}
