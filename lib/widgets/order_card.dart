import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../assitantMethodes/assistan_methods.dart';
import '../mainScreens/order_details_screen.dart';

class OrderCard extends StatefulWidget {

  final int? itemCount;
  final List<DocumentSnapshot>? data ;
  final String? orderId ;

  final String? title ;
  final String? price ;
  final String? itemid ;
  final String? img ;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderId,
    this.price,
    this.title,
    this.itemid,
    this.img,
    });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailScreen(orderId : widget.orderId)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            //quantity number
            IconButton(
                icon: const Icon(Icons.remove,size: 15,),
                onPressed:() {
                  clearCartNow(context);
                }
            ),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "Cairo"
                          ),
                        ),

                        Text(
                          "x" + widget.itemCount.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize:12,
                              fontFamily: "Cairo"
                          ),
                        ),

                        Row(
                          children: [

                            const Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "₪",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0 , top: 2.8),
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: "Cairo"

                                ),
                              ),
                            ),
                            Text(
                              widget.price.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: "Cairo"
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0 , bottom: 6.0 , right:26.0),
                      child: Container(
                        height: 70,
                        width: 90,
                        child: ClipRRect(
                          borderRadius:  BorderRadius.circular(2),
                          child: Image.network(
                            widget.img.toString(),
                            fit: BoxFit.fill, ),),

                      ),
                    ),
                  ],
                ),
              ],
            ),




          ],
        ),
      )
    );
  }
}

