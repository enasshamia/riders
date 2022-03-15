import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/mainScreens/home_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(
              "\$" +  previousRiderEarnings,
              style: const TextStyle(
                fontSize: 80,
                color: Colors.white,
                fontFamily: "Signatra"
              ),
            ),
            const Text(
             "Total Earnings",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                 letterSpacing: 3,
                 fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

            },
            child: const Card(
              color: Colors.white54,
              margin: EdgeInsets.symmetric(vertical: 40 , horizontal: 140),
              child: ListTile(
                leading: Icon(Icons.arrow_back,color: Colors.white,),
                title: Text("back", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),textAlign: TextAlign.center,),
              ),
            ),
          )

        ],
      ),
          )),
    );
  }
}
