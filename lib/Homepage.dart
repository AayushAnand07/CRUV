import 'package:bookit/seating.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUV Assignment",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(child: SizedBox(height:50,child: ElevatedButton( style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),), onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Seating())),child: const Text("View Seat"))),),
      ),
    );
  }
}
