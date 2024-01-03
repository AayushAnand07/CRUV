import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../Model/SeatModel.dart';

Widget SeatLayout(BuildContext context, int compartment, int searchSeatNo) {
  int seatIndex = compartment * 8;

  return Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 1,
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                SeatContainer(seatIndex, "LOWER", searchSeatNo),
                SizedBox(
                  width: 2,
                ),
                SeatContainer(seatIndex + 1, "MIDDLE", searchSeatNo),
                SizedBox(
                  width: 2,
                ),
                SeatContainer(seatIndex + 2, "UPPER", searchSeatNo),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  SeatContainer(seatIndex + 6, "S.UPPER", searchSeatNo),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SeatContainer(seatIndex + 3, "LOWER", searchSeatNo),
                SizedBox(
                  width: 2,
                ),
                SeatContainer(seatIndex + 4, "MIDDLE", searchSeatNo),
                SizedBox(
                  width: 2,
                ),
                SeatContainer(seatIndex + 5, "UPPER", searchSeatNo),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  SeatContainer(seatIndex + 7, "S.LOWER", searchSeatNo),

                ],
              ),

            ),
          ],
        ),
      ),
    ],
  );
}

class SeatContainer extends StatefulWidget {
  int seatNo;
  String title;
  int SearchSeatNo;

  SeatContainer(this.seatNo, this.title, this.SearchSeatNo);

  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {

  Color seatColor = Color(0xffCEEAFF);
  Color textColor = Color(0xff2696FE);
  bool isTapped = false;
  bool isSearched = false;
  void resetTappedState() {
    setState(() {
      isTapped = false;
    });
  }

  Future<List<SeatData>> fetchSeatData() async {
    final String jsonString = await rootBundle.loadString('asset/chart.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    final List<dynamic> nestedList = data['seats'] as List<dynamic>;

    return nestedList.map((seat) => SeatData.fromJson(seat)).toList();
  }


  @override
  Widget build(BuildContext context) {

    if (widget.SearchSeatNo - 1 == widget.seatNo || isTapped) {
      seatColor =  Color(0xff2696FE);
      textColor = Colors.white;
    }
      else {
      seatColor = Color(0xffCEEAFF);
      textColor = Color(0xff2696FE);
    }

    return GestureDetector(
         onTap: () async {


        setState(() {
          isTapped = true;
        });

        await showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder<List<SeatData>>(
            future: fetchSeatData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<SeatData> seatData = snapshot.data!;
                final SeatData selectedSeat = seatData.firstWhere(
                      (seat) => seat.seatNo == widget.seatNo + 1,
                  orElse: () => SeatData(seatNo: widget.seatNo + 1, reservations: []),
                );

                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0,top: 18.0),
                          child: Text("Seat No. "+(widget.seatNo + 1).toString(),style: TextStyle(color: Color(0xff2696FE),fontWeight: FontWeight.bold,fontSize: 25),),
                        ),  Padding(
                          padding: const EdgeInsets.only(left: 18.0,top: 5.0),
                          child: Text("Reservations ",style: TextStyle(color: Color(0xff2696FE),fontWeight: FontWeight.bold,fontSize: 25),),

                        ),
                        (selectedSeat.reservations.length != 0)
                            ? Column( // Use a Column to display multiple reservations
                          children: selectedSeat.reservations.map((reservation) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height * 0.055,
                                    child: Card(
                                      child: Center(
                                        child: Text(reservation.from), // Access each reservation.from
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height * 0.055,
                                    child: Card(
                                      child: Center(
                                        child: Text(reservation.to), // Access each reservation.from
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(), // Convert the map result to a list of widgets
                        )
                            : Center(
                          child: Text("No Reservations", style: TextStyle(color: Color(0xff2696FE), fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data')); // Handle errors
              } else {
                return Center(child: CircularProgressIndicator()); // Show loading indicator
              }
            },
          );
        },
        ).then((value) => resetTappedState());

      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: seatColor, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((widget.seatNo + 1).toString(),
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(widget.title,
                style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

// Widget SeatContainer(int seatNo,String title,int searchSeatNo){
//  Color seatColor = Color(0xffCEEAFF);
//  Color textColor = Color(0xff2696FE);
//   if (searchSeatNo - 1 == seatNo ) {
//       seatColor = textColor;
//       textColor = Colors.white;
//     }
//
//   return GestureDetector(
//     onTap: (){},
//     child: Container(height: 70,width: 70,decoration: BoxDecoration(color:seatColor,borderRadius: BorderRadius.circular(5)),child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//
//         Text((seatNo+1).toString(),style: TextStyle(color:textColor,fontSize: 20,fontWeight: FontWeight.bold)),
//         Text(title,style: TextStyle(color:textColor,fontSize: 12,fontWeight: FontWeight.bold))
//       ],
//     ),),
//   );
//
// }
