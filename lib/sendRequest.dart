import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'main.dart';


var isSet =false;
class SendRequest extends StatefulWidget {

  const SendRequest({Key? key}) : super(key: key);

  @override
  State<SendRequest> createState() => _SendRequestState();
}
class _SendRequestState extends State<SendRequest> {
  var checkStatus;
  var set=true;
  @override

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: const Text("Request Status"),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Test Case Passed !",style: TextStyle(fontSize: 20),),
                const SizedBox(
                  height: 20,
                ),


                Container(
                  height: 50,
                  width: 330,
                  padding: const EdgeInsets.only(left: 25, right: 10,top: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('status').onValue,
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');

                          return Text("Motor Status : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black,fontSize: 17),);
                        } else {
                          return const Text("Loading . . ");
                        }      }
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 330,
                  padding: const EdgeInsets.only(left: 25, right: 10,top: 12),

                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('soil').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');
                          return Text("Selected Soil : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black,fontSize: 17),);
                        } else {
                          return const Text("Loading . . ");
                        }      }
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 330,
                  padding: const EdgeInsets.only(left: 25, right: 10,top: 12),

                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('crop').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');
                          return Text("Selected Crop : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black,fontSize: 17),);
                        } else {
                          return const Text("Loading . . ");
                        }      }
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: 330,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                      ),

                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder:(context) => Drop(),)); },
                      child: const Text(
                        'Test Again',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),

              ],

            ),

          ),



        ],
      ) ,
    );
  }
}
