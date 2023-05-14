import 'dart:convert';
import 'dart:math';
import 'package:dropdown/sendRequest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global.dart';
import 'package:http/http.dart' as http;

var state;
var motorStatus;
var nitro;
var pota;
var phos;
String On = 'On';
String Off = 'Off';
var isLoading=false;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCeCrg7IO-BaFt4D9wbfcb3nIQzyGmH1HI",
            authDomain: "agrotech-d6e76.firebaseapp.com",
            databaseURL: "https://agrotech-d6e76-default-rtdb.firebaseio.com",
            projectId: "agrotech-d6e76",
            storageBucket: "agrotech-d6e76.appspot.com",
            messagingSenderId: "998053960418",
            appId: "1:998053960418:web:5277911e3f09cbedbddcbb",
            measurementId: "G-E16TDEF9SN"));
  } else {
    await Firebase.initializeApp();
  }

  final pageState = FirebaseDatabase.instance.ref("Page");

  await pageState.child('').get().then((value) {
    state = value.value;
  });

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: getStatus(),
  ));
}

Widget getStatus() {
  if (state == 1) {
    return const Drop();
  }
  if (state == 2) {
    return const Scaffold(
        body:
            Center(child: Text("Testing can be done in Automatic Mode only")));
  } else {
    return const Scaffold(
        body: Center(
            child: Text(
                "Select Crop Soil and Mode through AgroTech Application in Automatic mode")));
  }
}

class Drop extends StatefulWidget {
  const Drop({Key? key}) : super(key: key);

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {

  void check(){
     setState(() {
       isLoading=true;
     });
  }
  void reset(){
    setState(() {
      isLoading=false;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget CropSelection(String selectedSoil) {

    switch (selectedSoil) {
      case 'Black Soil':
        {
          return DropdownButton(
            focusColor: Colors.white,
            dropdownColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            iconSize: 36,
            isExpanded: false,
            style: const TextStyle(color: Colors.black, fontSize: 22),
            hint: const Text("Select Soil"),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Colors.black, size: 27),

            value: forBlack,

            // Array list of items
            items: forBlackList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forBlack = newValue!;
                selectedCrop = forBlack;
              });
            },
          );
        }
      case 'Alluvial Soil':
        {
          return DropdownButton(

            focusColor: Colors.white,
            dropdownColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            iconSize: 36,
            isExpanded: false,
            style: const TextStyle(color: Colors.black, fontSize: 22),
            hint: const Text("Select Soil"),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Colors.black, size: 27),
            value: forAlluvial,

            // Down Arrow Icon


            // Array list of items
            items: forAlluvialList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forAlluvial = newValue!;
                selectedCrop = forAlluvial;
              });
            },
          );
        }

      case 'Laterite Soil':
        {
          return DropdownButton(
            focusColor: Colors.white,
            dropdownColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            iconSize: 36,
            isExpanded: false,
            style: const TextStyle(color: Colors.black, fontSize: 22),
            hint: const Text("Select Soil"),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Colors.black, size: 27),
            value: forLaterite,

            // Down Arrow Icon


            // Array list of items
            items: forLateriteList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forLaterite = newValue!;
                selectedCrop = forLaterite;
              });
            },
          );
        }
      case 'Arid Soil':
        {
          return DropdownButton(
            focusColor: Colors.white,
            dropdownColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            iconSize: 36,
            isExpanded: false,
            style: const TextStyle(color: Colors.black, fontSize: 22),
            hint: const Text("Select Soil"),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Colors.black, size: 27),
            value: forArid,

            // Down Arrow Icon


            // Array list of items
            items: forAridList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forArid = newValue!;
                selectedCrop = forArid;
              });
            },
          );
        }
      default:
        {
          return const Text("Select Soil First");
        }
    }
  }

  Future<void> checkParameters() async {
    final statusRef = FirebaseDatabase.instance.ref("status");

    await statusRef.get().then((value) {
      motorStatus = value.value;
    });
    print("Current Motor Status is $motorStatus");



    // final NitroRef = FirebaseDatabase.instance.ref("nitrogen");
    //
    // await NitroRef.get().then((value) {
    //   nitro = value.value;
    // });
    //
    // final  phosRef= FirebaseDatabase.instance.ref("phosphorus");
    //
    // await phosRef.get().then((value) {
    //   phos = value.value;
    // });
    //
    //
    // final  potaREf= FirebaseDatabase.instance.ref("potassium");
    //
    // await potaREf.get().then((value) {
    //   pota = value.value;
    // });


    switch (selectedSoil) {
      case 'Black Soil':
        {
          if (selectedCrop == 'Rice') {

            if ( (randomTemperature > 32.0) || (randomHumidity < 60.0)    || (randomMoisture < 80.0)    || (randomWaterReq<1500.0)  )
            {


              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            }
            else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }

          }

          if (selectedCrop == 'Wheat') {

            if ( (randomTemperature > 26.0) || (randomHumidity <50.0)     || (randomMoisture < 50.0)    || (randomWaterReq<600.0)     )
            {

              var time = DateTime.now();

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            }
            else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Pulses') {

            if ( (randomTemperature > 30.0 ) || (randomHumidity <50.0)     || (randomMoisture <60.0)    || (randomWaterReq<500.0)   )

            {

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Soyabean') {

            if ( (randomTemperature > 30.0 ) || (randomHumidity < 60.0)     || (randomMoisture < 60.0)    || (randomWaterReq<600.0)  )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Cereals') {

            if ( (randomTemperature >27) || (randomHumidity < 60.0)     || (randomMoisture < 60.0)    || (randomWaterReq<500.0)     )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Sugar Cane') {

            if ( (randomTemperature > 27.0) || (randomHumidity<60.0)     || (randomMoisture < 70.0)    || (randomWaterReq<1500.0)     )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Cotton') {

            if ( (randomTemperature > 35.0) || (randomHumidity <60.0)     || (randomMoisture < 50.0)    || (randomWaterReq<700.0)     )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Potato') {

            if ( (randomTemperature >20.0) || (randomHumidity < 60.0)     || (randomMoisture <70.0)    || (randomWaterReq<500.0)     )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }

          if (selectedCrop == 'Termeric') {

            if ( (randomTemperature > 28.0) || (randomHumidity < 70.0)     || (randomMoisture < 70.0)    || (randomWaterReq<2000.0 )     )

            {
              print("You Entered Successfully");

              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'Off',
                "Currentmode": 'Automatic'
              });

              statusRef.set(On).onError((error, stackTrace) {
                print(error.toString());
              });
            } else {
              var time = DateTime.now();
              print(time);

              final historyRef = FirebaseDatabase.instance.ref("History");
              historyRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "time": DateTime.now().toString(),
                "Status": 'On',
                "Currentmode": 'Automatic'
              });
              statusRef.set('Off');
            }
          }


        }
        break;
      case 'Alluvial Soil':
        {}
        break;
      case 'Red and Yellow Soil':
        {}
        break;
      case 'Laterite Soil':
        {}
        break;
      case 'Arid Soil':
        {}
        break;
      default:
        {
          print("None of the Soil Match");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Dashboard"),
        ),
        body: Center(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 330,
                    padding: const EdgeInsets.only(left: 16, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        iconSize: 36,
                        isExpanded: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        hint: const Text("Select Soil"),
                        value: selectedSoil,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.black, size: 27),

                        // Array list of items
                        items: Soils.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSoil = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 50,
                      width: 330,
                      padding: const EdgeInsets.only(left: 16, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                          child: CropSelection(selectedSoil))),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomTemperature = Random().nextDouble() * 100;
                      });
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Temperature',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomTemperature \u2103",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomHumidity = Random().nextDouble() * 100;                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomHumidity %",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomMoisture = Random().nextDouble() * 100;                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Soil Moisture',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomMoisture %",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomWaterReq = Random().nextDouble() * 2000;                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Water Requirement',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomWaterReq mm",style: const TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomPhosphorus = Random().nextDouble() * 100;
                      });
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Phosphorus',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomPhosphorus miligram",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomNitrogen = Random().nextDouble() * 100;
                      });
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Nitrogen',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomNitrogen miligram",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        randomPotassium = Random().nextDouble() * 100;
                      });
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                            height: 80,
                            width:330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Potassium',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("$randomPotassium miligram",style: TextStyle(color: Colors.deepOrange,fontSize: 17),)

                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                        onPressed: () async {

                          check();

                          final phosREf=FirebaseDatabase.instance.ref('phosphorus');
                          await phosREf.set(randomPhosphorus).then((value){}).onError((error, stackTrace) {
                            print("Unable to set Phosphorus");
                          });

                          final nitroREf=FirebaseDatabase.instance.ref('nitrogen');
                          await nitroREf.set(randomNitrogen).then((value){}).onError((error, stackTrace) {
                            print("Unable to set Nitogen");
                          });

                          final potassREf=FirebaseDatabase.instance.ref('potassium');
                          await potassREf.set(randomPotassium).then((value){}).onError((error, stackTrace) {
                            print("Unable to set Potassium");
                          });

                          final soilRef = FirebaseDatabase.instance.ref("soil");
                          await soilRef
                              .set(selectedSoil)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          final cropRef = FirebaseDatabase.instance.ref("crop");
                          await cropRef
                              .set(selectedCrop)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          final humidityRef =
                              FirebaseDatabase.instance.ref("humidity");
                          await humidityRef
                              .set(randomHumidity)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          final waterRef =
                          FirebaseDatabase.instance.ref("water");
                          await waterRef
                              .set(randomWaterReq)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          final moistureRef =
                              FirebaseDatabase.instance.ref("moisture");
                          await moistureRef
                              .set(randomMoisture)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          final temperatureRef =
                              FirebaseDatabase.instance.ref("temperature");
                          await temperatureRef
                              .set(randomTemperature)
                              .then((value) {})
                              .onError((error, stackTrace) {
                            print(error.toString());
                          });

                          checkParameters();

                          var data = {
                            'to':
                                'fch6ZugcTN6LgOK1eL6XwE:APA91bHaB07K87drYC6EE7xkgjlxCz-MF34Pu4oVetWgHa5a1rD89V7hELjSgbLV0TA8LQqHmQPrvbE9u5-yBjyuqUSfH0dqUfA0XU2unAIJemkNbndPYzLVMAoobyJ9A8zrHOflDswB',
                            'priority': 'high',
                            'notification': {
                              'title': 'Pranay',
                              'body': 'It Works!!'
                            }
                          };
                          await http.post(
                              Uri.parse('https://fcm.googleapis.com/fcm/send'),
                              body: jsonEncode(data),
                              headers: {
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Authorization':
                                    'key=AAAAwgb2AnY:APA91bFjvlpMDiRF8_OJXUDyAsFzFZPwpnx_ZC5vTGXai6WJOjVHjC1hFoafXLZYdKCm95yNWsZm1aNjK7hXUe6hHAKo5cY3Ga_JTmxkz60xGgWYMnlti4R7BDGnWwaNsfwBT4dW6JNd'
                              });
                          reset();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SendRequest(),
                              ));
                        },
                        child: isLoading?const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ):const Text("Submit Test Case",style: TextStyle(fontSize: 20),)

                      )
                  ),
                ],
              )),
        ));
  }
}
