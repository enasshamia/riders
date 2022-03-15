import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/mainScreens/order_details_screen.dart';
import 'package:lhad_albiet_riders/models/items.dart';
import 'package:lhad_albiet_riders/models/order.dart';
import 'package:lhad_albiet_riders/widgets/progress_bar.dart';
import '../assitantMethodes/assistan_methods.dart';
import '../widgets/app_bar.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  Future getDocs() async {
    List uId = [];
     var querySnapshot = await FirebaseFirestore.instance.collection("orders").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data()["orderBY"];
      if(uId.isEmpty){
        uId.add(a);
      }else{
        if(uId.contains(a)){
          print("");
        } else{
          uId.add(a);
        }
      }
    }
    print(uId.toString()+"saaaaaaaaaaaaaaaaaaaaaa");
    return uId;
  }


  String? userID;
  List itemID = [];
  List idUser = [];
  List defaultItemList = [];
  

  getID() {
    int i = 0;
    String? item;
    for (i; i != defaultItemList.length; i++) {
       item = defaultItemList[i].toString();
    }
    return item ;

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:MyappBar() ,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("orders").where("status" ,isEqualTo: "normal").snapshots(),
          builder: (c , snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (c, index) {
                  Order order = Order.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String , dynamic>
                  );
                  userID = order.userId.toString();
                  idUser.add(userID);
                  print(userID.toString()+"aa");

                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                             Column(
                            children: [
                              Text(order.sellerName.toString()),
                              Text( "السعر : "+ order.price.toString()),
                            ],
                          ),
                          Container(
                            height: 70,
                            width: 90,
                            child: ClipRRect(
                              borderRadius:  BorderRadius.circular(2),
                              child: Image.network(
                                order.sellerAvatar.toString(),
                                fit: BoxFit.fill, ),),),
                        ],
                      ),
                    ),
                    onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetailScreen(orderId: idUser[index])));
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
