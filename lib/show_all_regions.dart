import 'package:flutter/material.dart';
import 'package:flutter_application_1/regions_wise_tour.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowAllRegions extends StatefulWidget {
  const ShowAllRegions({super.key});

  @override
  State<ShowAllRegions> createState() => _ShowAllRegionsState();
}

class _ShowAllRegionsState extends State<ShowAllRegions> {
  List myregions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all_regions_fun();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollbar = ScrollController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: myregions == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : myregions.isEmpty
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
                        itemCount: myregions.length,
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
                                          builder: (context) => RegionsWise(
                                              region_id: myregions[index]['id']
                                                  .toString())));
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
                                              0.10,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              myregions[index]['region_image']
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // Text(
                                        //   myregions[index]['region_name']
                                        //       .toString(),
                                        //   style: const TextStyle(
                                        //       fontSize: 20,
                                        //       color: fontstyle.fontcolor,
                                        //       fontWeight: FontWeight.bold),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
      ),
      // body: Center(
      //   child: ListView.builder(
      //       itemCount: myregions.length,
      //       itemBuilder: (context, index) {
      //         return Column(
      //           children: [
      //             Container(
      //                 padding: const EdgeInsets.all(16),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     ClipRRect(
      //                       borderRadius: BorderRadius.circular(10),
      //                       child: Container(
      //                         height: MediaQuery.of(context).size.height * 0.30,
      //                         width: double.infinity,
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(10),
      //                           child: Image.network(
      //                             fit: BoxFit.cover,
      //                             myregions[index]['region_image'].toString(),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 )),
      //           ],
      //         );
      //       }),
      // ),
    );
  }

  void all_regions_fun() async {
    var url = Uri.https('bestvoyage.co.in', 'api/regions-list.php');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    setState(() {
      myregions = mymap['data'];
    });
  }
}
