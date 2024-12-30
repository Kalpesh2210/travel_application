import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/fonts_style/font_theme.dart';
import 'package:flutter_application_1/tour_days_details.dart';
import 'package:flutter_application_1/tour_hotels_details.dart';
import 'package:flutter_application_1/tour_images_details.dart';
import 'package:http/http.dart' as http;

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({super.key, required this.details_id});
  final String details_id;

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  var mydata = {};
  final ScrollController tourdetail_scrollbar1 = new ScrollController();
  final ScrollController tourdetail_scrollbar2 = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tourdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              Text(widget.details_id),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      mydata.isNotEmpty && mydata['tour_feature_image'] != null
                          ? mydata['tour_feature_image'].toString()
                          : 'No Images',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.green,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )),
              ),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: Text(
                  mydata['tour_name'].toString(),
                  style: TextStyle(
                      fontSize: fontstyle.fontheadingsize.toDouble(),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tour Details',
                  style: TextStyle(
                      fontSize: fontstyle.fonttitlesize.toDouble(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Scrollbar(
                thickness: 5,
                radius: const Radius.circular(10),
                trackVisibility: true,
                controller: tourdetail_scrollbar1,
                child: SizedBox(
                  height: 250,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${mydata['tour_highlights']}',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Amenities',
                  style: TextStyle(
                      fontSize: fontstyle.fonttitlesize.toDouble(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.dining,
                          size: 30,
                        ),
                      ),
                      Text('Food'),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.bed,
                          size: 30,
                        ),
                      ),
                      Text('Bed')
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.shower,
                          size: 30,
                        ),
                      ),
                      Text('Shower')
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.wifi,
                          size: 30,
                        ),
                      ),
                      Text('WiFi')
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.health_and_safety_outlined,
                          size: 30,
                        ),
                      ),
                      Text('Safety')
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Travelers Photos',
                  style: TextStyle(
                      fontSize: fontstyle.fonttitlesize.toDouble(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              mydata['tour_images'] != null && mydata.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: SizedBox(
                                height: 205,
                                width: 200,
                                child: mydata['tour_images'] != null &&
                                        mydata['tour_images'] is List &&
                                        mydata['tour_images'].isNotEmpty &&
                                        mydata['tour_images'].length > 0 &&
                                        mydata['tour_images'][0] != null
                                    ? Image.network(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Text('No image'),
                                          );
                                        },
                                        mydata['tour_images'][0].toString(),
                                        fit: BoxFit.fill,
                                      )
                                    : Text('No Images'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: mydata['tour_images'] != null &&
                                          mydata['tour_images'] is List &&
                                          mydata['tour_images'].isNotEmpty &&
                                          mydata['tour_images'].length > 1 &&
                                          mydata['tour_images'][1] != null
                                      ? Image.network(
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Text('No image'),
                                            );
                                          },
                                          mydata['tour_images'][1].toString(),
                                          fit: BoxFit.fill,
                                        )
                                      : Text('No Images'),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: Stack(
                                    fit: StackFit.passthrough,
                                    children: [
                                      mydata['tour_images'] != null &&
                                              mydata['tour_images'] is List &&
                                              mydata['tour_images']
                                                  .isNotEmpty &&
                                              mydata['tour_images'].length >
                                                  2 &&
                                              mydata['tour_images'][2] != null
                                          ? Image.network(
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Center(
                                                  child: Text('No image'),
                                                );
                                              },
                                              mydata['tour_images'][2]
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            )
                                          : const Text('No Images'),
                                      mydata['tour_images'] != null &&
                                              mydata['tour_images'] is List &&
                                              mydata['tour_images']
                                                  .isNotEmpty &&
                                              mydata['tour_images'].length >
                                                  2 &&
                                              mydata['tour_images'][2] != null
                                          ? Positioned(
                                              right: 25,
                                              bottom: 25,
                                              left: 25,
                                              top: 25,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: IconButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const TourImagesDetails()));
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                  ),
                                                  iconSize: 30,
                                                ),
                                              ),
                                            )
                                          : Text('')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const Text('No Images'),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tour Visa Checklist',
                  style: TextStyle(
                      fontSize: fontstyle.fonttitlesize.toDouble(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              mydata['tour_visa_checklist'] != "" &&
                      mydata['tour_visa_checklist'] != null
                  ? Scrollbar(
                      thickness: 5,
                      trackVisibility: true,
                      radius: const Radius.circular(10),
                      child: SizedBox(
                        height: 250,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${mydata['tour_visa_checklist']}',
                          ),
                        ),
                      ),
                    )
                  : const Text('No Data '),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Additional Information',
                  style: TextStyle(
                      fontSize: fontstyle.fonttitlesize.toDouble(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TourDayDetails(
                              tourid_day: widget.details_id.toString())));
                },
                trailing: const Icon(Icons.double_arrow),
                tileColor: const Color.fromARGB(255, 192, 220, 193),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text(
                  'Itinerary Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontstyle.fonttitlesize.toDouble()),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TourHotelsDetails(
                              tourid_hotel: widget.details_id.toString())));
                },
                trailing: const Icon(Icons.double_arrow),
                tileColor: const Color.fromARGB(255, 192, 220, 193),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text(
                  'Hotels Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontstyle.fonttitlesize.toDouble()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void tourdetails() async {
    var url = Uri.https(
        'bestvoyage.co.in', 'api/tour-details.php', {'id': widget.details_id});
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    setState(() {
      mydata = mymap;
    });
  }
}
