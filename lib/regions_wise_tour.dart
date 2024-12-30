import 'package:flutter/material.dart';
import 'package:flutter_application_1/fonts_style/font_theme.dart';
import 'package:flutter_application_1/tour_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegionsWise extends StatefulWidget {
  const RegionsWise({super.key, required this.region_id});
  final String region_id;

  @override
  State<RegionsWise> createState() => _RegionsWiseState();
}

class _RegionsWiseState extends State<RegionsWise> {
  var myregions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    regions_wise_tour_fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: myregions.isEmpty
            ? const Center(
                child: Text('No data found'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: myregions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDetailsPage(
                                      details_id: myregions[index]['id'])));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height *
                              0.20, // Set the desired height
                          child: Row(
                            children: [
                              SizedBox(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    myregions[index]['tour_feature_image']
                                        .toString(),
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          myregions[index]['tour_name']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: fontstyle.fonttitlesize
                                                  .toDouble()),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              myregions[index]['region_name']
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              myregions[index]['no_of_days']
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                    height: 300,
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          buildrow(
                                                            'Tour Name ',
                                                            myregions[index][
                                                                    'tour_name']
                                                                .toString(),
                                                          ),
                                                          buildrow(
                                                            'No Of Days',
                                                            myregions[index][
                                                                    'no_of_days']
                                                                .toString(),
                                                          ),
                                                          buildrow(
                                                            'Tour Type',
                                                            myregions[index][
                                                                    'tour_type_name']
                                                                .toString(),
                                                          ),
                                                          buildrow(
                                                            'Region Name',
                                                            myregions[index][
                                                                    'region_name']
                                                                .toString(),
                                                          ),
                                                          buildrow(
                                                              'Available Dates',
                                                              myregions[index][
                                                                              'dates'] !=
                                                                          null &&
                                                                      (myregions[index]['dates']
                                                                              as List)
                                                                          .isNotEmpty
                                                                  ? SizedBox(
                                                                      height:
                                                                          50,
                                                                      child: ListView
                                                                          .builder(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        itemCount:
                                                                            (myregions[index]['dates'] as List).length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                dateindex) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 4),
                                                                            child:
                                                                                Card(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: const BorderSide(color: Colors.green)),
                                                                              elevation: 5,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(3),
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(myregions[index]['dates'][dateindex]),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  : 'no data'),
                                                          // Expanded(
                                                          //   child: Container(
                                                          //     height: 100,
                                                          //     child: myregions[index]
                                                          //                     [
                                                          //                     'dates'] !=
                                                          //                 null &&
                                                          //             (myregions[index]['dates']
                                                          //                     as List)
                                                          //                 .isNotEmpty
                                                          //         ? ListView
                                                          //             .builder(
                                                          //                 itemCount:
                                                          //                     (myregions[index]['dates'] as List)
                                                          //                         .length,
                                                          //                 itemBuilder:
                                                          //                     (context,
                                                          //                         dateindex) {
                                                          //                   return Padding(
                                                          //                     padding:
                                                          //                         EdgeInsets.symmetric(vertical: 5.0),
                                                          //                     child:
                                                          //                         Text(
                                                          //                       myregions[index]['dates'][dateindex],
                                                          //                       style: TextStyle(fontSize: 20),
                                                          //                     ),
                                                          //                   );
                                                          //                 })
                                                          //         : const Text(
                                                          //             'No Dates Available',
                                                          //             style: TextStyle(
                                                          //                 fontSize:
                                                          //                     20),
                                                          //           ),
                                                          //   ),
                                                          // ),
                                                          buildrow(
                                                              'Starting Cost',
                                                              myregions[index][
                                                                  'starting_cost']),
                                                        ],
                                                      ),
                                                    ));
                                              });
                                        },
                                        child: const Text(
                                          'All Details',
                                          style:
                                              TextStyle(color: Colors.indigo),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                                myregions[index]
                                                        ['starting_cost']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }

  void regions_wise_tour_fun() async {
    var url = Uri.https('bestvoyage.co.in', 'api/region-wise-tour-list.php',
        {'region_id': widget.region_id.toString()});
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    setState(() {
      if (mymap['flag'] == "1") {
        myregions = mymap['data'];
      }
    });
  }

  buildrow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(label)),
          Expanded(flex: 5, child: value is Widget ? value : Text('$value')),
        ],
      ),
    );
  }
}
