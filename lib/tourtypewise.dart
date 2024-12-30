import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/fonts_style/font_theme.dart';
import 'package:flutter_application_1/tour_details.dart';
import 'package:http/http.dart' as http;

class MyTourType extends StatefulWidget {
  const MyTourType({super.key, required this.tourid});
  final String tourid;

  @override
  State<MyTourType> createState() => _MyTourTypeState();
}

class _MyTourTypeState extends State<MyTourType> {
  var tourtypelist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tourtype();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollbar = ScrollController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: tourtypelist == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : tourtypelist.isEmpty
                ? const Center(
                    child: Text('No data found'),
                  )
                : Scrollbar(
                    controller: scrollbar,
                    thumbVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(10),
                    child: ListView.builder(
                        controller: scrollbar,
                        padding: const EdgeInsets.all(16),
                        itemCount: tourtypelist.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyDetailsPage(
                                              details_id: tourtypelist[index]
                                                  ['id'])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              tourtypelist[index]
                                                      ['tour_feature_image']
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Center(
                                                  child: Icon(Icons.error),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(
                                          tourtypelist[index]['tour_name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: fontstyle.fontcolor,
                                              fontSize: fontstyle
                                                  .fontheadingsize
                                                  .toDouble()),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Opacity(
                                          opacity: 0.4,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.location_on),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                tourtypelist[index]
                                                        ['region_name']
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Opacity(
                                          opacity: 0.4,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.calendar_month),
                                              Flexible(
                                                  child: Text(
                                                tourtypelist[index]
                                                        ['no_of_days']
                                                    .toString(),
                                              ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Opacity(
                                          opacity: 0.4,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.travel_explore),
                                              Flexible(
                                                  child: Text(
                                                tourtypelist[index]
                                                        ['tour_type_name']
                                                    .toString(),
                                              ))
                                            ],
                                          ),
                                        ),
                                        Align(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // const Icon(
                                            //   Icons.currency_rupee_sharp,
                                            //   color: fontstyle.fontcolor,
                                            // ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  minimumSize:
                                                      const Size(300, 40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  foregroundColor:
                                                      Colors.white),
                                              onPressed: () {},
                                              child: Text(
                                                tourtypelist[index]
                                                        ['starting_cost']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
      ),
    );
  }

  void tourtype() async {
    var url = Uri.https('bestvoyage.co.in', 'api/tour-type-wise-tour-list.php',
        {'tour_type_id': widget.tourid.toString()});
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    setState(() {
      if (mymap['flag'] == '1') {
        tourtypelist = mymap['data'];
      }
    });
  }
}
