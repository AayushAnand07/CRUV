import 'package:flutter/material.dart';

import 'Widgets/seatLayout.dart';

class Seating extends StatefulWidget {
  const Seating({super.key});

  @override
  State<Seating> createState() => _SeatingState();
}

class _SeatingState extends State<Seating> {
  ScrollController _scrollController = ScrollController();
  int searchBerth = 0;
  bool isSelected=false;
  FocusNode _focusNode = FocusNode();
bool isediting=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Finder', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05,left:MediaQuery.of(context).size.height*0.01, bottom: MediaQuery.of(context).size.height*0.04 ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Color(0xff2696FE),fontWeight: FontWeight.bold ),

                      cursorColor: Color(0xff2696FE),
                      focusNode: _focusNode,

                      onChanged: (value) {

                        setState(() {
                          if (value != "") {
                            isediting=true;
                            searchBerth = int.parse(value);
                            _scrollController.animateTo((searchBerth>31)?searchBerth*20.0:0, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else {
                            searchBerth = 0;
                            isediting=false;
                          }
                        });
                      },


                      decoration: InputDecoration(
                        hintText: "Enter Seat Number...",
                        hintStyle: TextStyle(color: Color(0xff2696FE),fontWeight: FontWeight.bold),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff2696FE), width: 3.0),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff2696FE), width: 3.0),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Add border radius (optional)
                        ),),
                    ),
                  ),
                ),



                Flexible(child: SizedBox(height:50,child: ElevatedButton(onPressed:(isediting)? (){
                  _focusNode.unfocus();
                }:null, style: ButtonStyle(
                  backgroundColor:(isediting)? MaterialStateProperty.all(Colors.blue):MaterialStateProperty.all(Colors.grey),
                  
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ), child: Text("Find",style: TextStyle(color: Colors.white,fontSize: 20   ),))))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 9,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(onTap:(){

                 }, child: SeatLayout(context, index, searchBerth));
              },
            ),
          )
        ],
      ),
    );
  }
}
