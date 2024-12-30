import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/fonts_style/font_theme.dart';
import 'package:http/http.dart' as http;

class TourHotelsDetails extends StatefulWidget {
  const TourHotelsDetails({super.key, required this.tourid_hotel});
  final String tourid_hotel;

  @override
  State<TourHotelsDetails> createState() => _TourHotelsDetailsState();
}

class _TourHotelsDetailsState extends State<TourHotelsDetails> {
  Map<String, dynamic>? myhotels;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_hotle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: myhotels == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : myhotels!['tour_hotels'] == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: myhotels!['tour_hotels'].length,
                    itemBuilder: (context, index) {
                      var myhotels_details = myhotels!['tour_hotels'][index];
                      return ExpansionTile(
                        initiallyExpanded: false,
                        title: Text(
                          myhotels_details!['city_name'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontstyle.fonttitlesize.toDouble()),
                        ),
                        children: List.generate(
                            myhotels_details['hotels'].length, (hotleindex) {
                          final hotel = myhotels_details['hotels'][hotleindex];
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 30, right: 10),
                            title: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.white,
                                height: 350,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hotel Name',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Card(
                                      shadowColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          hotel['hotel_name'].toString(),
                                          style: TextStyle(
                                              fontSize: fontstyle.fonttitlesize
                                                  .toDouble()),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Hotel Address',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Card(
                                      shadowColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          hotel['hotel_details'].toString(),
                                          style: TextStyle(
                                              fontSize: fontstyle.fonttitlesize
                                                  .toDouble()),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Time To Stay',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Card(
                                      shadowColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          hotel['no_of_days'].toString(),
                                          style: TextStyle(
                                              fontSize: fontstyle.fonttitlesize
                                                  .toDouble()),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Hotel Rating',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    Card(
                                      shadowColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          '${hotel['hotel_rating']} Star Rating',
                                          style: TextStyle(
                                              fontSize: fontstyle.fonttitlesize
                                                  .toDouble()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ));
  }

  void fetch_hotle() async {
    try {
      var url = Uri.https('bestvoyage.co.in', 'api/tour-details.php',
          {'id': widget.tourid_hotel});
      var response = await http.get(url);
      print(response.statusCode);
      print(response.body);
      Map<String, dynamic> mymap = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          myhotels = mymap;
        });
      } else {
        throw Exception('Not Load Data');
      }
    } catch (e) {
      print('error ${e}');
    }
  }
}
