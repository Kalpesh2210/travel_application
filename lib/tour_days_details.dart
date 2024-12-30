import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/fonts_style/font_theme.dart';
import 'package:http/http.dart' as http;

class TourDayDetails extends StatefulWidget {
  const TourDayDetails({super.key, required this.tourid_day});
  final String tourid_day;

  @override
  State<TourDayDetails> createState() => _TourDayDetailsState();
}

class _TourDayDetailsState extends State<TourDayDetails> {
  Map<String, dynamic>? myTourDayDetails;

  @override
  void initState() {
    super.initState();
    fetchTourDayDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tour Details"),
      ),
      body: myTourDayDetails == null
          ? const Center(child: CircularProgressIndicator())
          : myTourDayDetails!['itinerary'] == null
              ? const Center(child: Text("No itinerary available"))
              : ListView.builder(
                  itemCount: myTourDayDetails!['itinerary'].length,
                  itemBuilder: (context, index) {
                    var itineraryItem = myTourDayDetails!['itinerary'][index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              color: Colors.white,
                              child: Text(
                                itineraryItem['tour_itinerary_day'].toString(),
                                style: TextStyle(
                                    fontSize:
                                        fontstyle.fontheadingsize.toDouble()),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            itineraryItem['tour_itinerary_title'].toString(),
                            style: TextStyle(
                                fontSize: fontstyle.fonttitlesize.toDouble()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(itineraryItem['tour_itinerary_details']
                              .toString()),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  void fetchTourDayDetails() async {
    try {
      var url = Uri.https('bestvoyage.co.in', 'api/tour-details.php',
          {'id': widget.tourid_day});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> mymap = json.decode(response.body);
        setState(() {
          myTourDayDetails = mymap;
        });
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        myTourDayDetails = {'itinerary': []}; // Fallback to avoid crashes
      });
    }
  }
}
