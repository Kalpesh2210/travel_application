import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/regions_wise_tour.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/show_all_regions.dart';
import 'package:flutter_application_1/tourtypewise.dart';
import 'dart:convert';
import 'fonts_style/font_theme.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Fetch_Tour();
    Fetch_Tour_Type();
    Fetch_Tour_Regions();
    Fetch_Review();
  }

  var mydata = [];
  var myimagelist = [];
  var mytourtype = [];
  var myregions = [];
  var userreview = [];
  // ignore: non_constant_identifier_names
  final ScrollController _scroll_controller1 = ScrollController();
  // ignore: non_constant_identifier_names
  final ScrollController _scroll_controller2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color.fromARGB(255, 228, 231, 228),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
            const Text(
              'Travia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                icon: const Icon(Icons.notifications))
            // Text(
            //   'Travia',
            //   style: TextStyle(),
            // ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(20, 40),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                      icon: const Icon(
                        Icons.view_column_rounded,
                        color: fontstyle.fontcolor,
                      ),
                      onPressed: () {},
                      label: const Text(
                        'Filter',
                        style: TextStyle(color: fontstyle.fontcolor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(20, 40),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                      icon: const Icon(
                        Icons.sort,
                        color: fontstyle.fontcolor,
                      ),
                      onPressed: () {},
                      label: const Text(
                        'Sort',
                        style: TextStyle(color: fontstyle.fontcolor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                      prefixIconColor: fontstyle.fontcolor,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: fontstyle.fontcolor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: fontstyle.fontcolor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Searching Your Dream Tour',
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Text(
                    'Trending Tours',
                    style: TextStyle(
                        fontSize: fontstyle.fontheadingsize.toDouble(),
                        fontWeight: FontWeight.bold,
                        color: fontstyle.fontcolor),
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mydata.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(5),
                          height: 250,
                          width: 250,
                          decoration: const BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: SizedBox(
                                  height: 200,
                                  width: 250,
                                  child: Image.network(
                                    mydata[index]['tour_feature_image']
                                        .toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          color: fontstyle.fontcolor,
                                          semanticsLabel: 'Loading',
                                          strokeCap: StrokeCap.butt,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                mydata[index]['tour_name'].toString(),
                                style: TextStyle(
                                    fontSize:
                                        fontstyle.fonttitlesize.toDouble(),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                        fit: BoxFit.cover,
                        'https://images.pexels.com/photos/1054218/pexels-photo-1054218.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SafeArea(
                  child: Text(
                    'Explore By Category',
                    style: TextStyle(
                        fontSize: fontstyle.fontheadingsize.toDouble(),
                        color: fontstyle.fontcolor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7 / 2,
                  child: Scrollbar(
                    controller: _scroll_controller1,
                    thumbVisibility: true,
                    thickness: 5.0,
                    radius: const Radius.circular(10),
                    child: GridView.builder(
                        controller: _scroll_controller1,
                        //scrollDirection: Axis.horizontal,
                        itemCount: mytourtype.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.18),
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyTourType(
                                                  tourid: mytourtype[index]
                                                      ['id'])));
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      child: Image.network(mytourtype[index]
                                              ['tour_type_image']
                                          .toString()),
                                    ),
                                  ),
                                  Text(
                                    mytourtype[index]['tour_type_name']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize:
                                            fontstyle.fonttitlesize.toDouble(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                SafeArea(
                    child: Text(
                  'Explore By Regions',
                  style: TextStyle(
                      fontSize: fontstyle.fontheadingsize.toDouble(),
                      color: fontstyle.fontcolor,
                      fontWeight: FontWeight.bold),
                )),
                // const SizedBox(
                //   height: 30,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.62,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scroll_controller2,
                    radius: const Radius.circular(10),
                    child: ListView.builder(
                      controller: _scroll_controller2,
                      itemCount: myregions.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegionsWise(
                                        region_id:
                                            myregions[index]['id'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(myregions[index]
                                        ['region_image']
                                    .toString()),
                              ),
                            ),
                            Text(
                              myregions[index]['region_name'].toString(),
                              style: TextStyle(
                                  fontSize: fontstyle.fonttitlesize.toDouble(),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShowAllRegions()));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                SafeArea(
                    child: Text(
                  'User Reviews',
                  style: TextStyle(
                      fontSize: fontstyle.fontheadingsize.toDouble(),
                      color: fontstyle.fontcolor,
                      fontWeight: FontWeight.bold),
                )),
                // const SizedBox(
                //   height: 30,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.7),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(userreview[index]
                                        ['testimonial_image']
                                    .toString()),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              height: 200,
                              child: ListView(
                                children: [
                                  Text(
                                    userreview[index]['testimonial_name']
                                        .toString(),
                                    style: TextStyle(
                                        color: fontstyle.fontcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            fontstyle.fonttitlesize.toDouble()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      userreview[index]['testimonial_details']
                                          .toString(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                      );
                    },
                    itemCount: userreview.length,
                  ),
                )

                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.30,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: userreview.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         width: MediaQuery.of(context).size.width * 0.8,
                //         decoration: const BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(16))),
                //         child: Image.network(
                //             userreview[index]['testimonial_image'].toString()),
                //         // child: ClipRRect(
                //         //   borderRadius: BorderRadius.circular(10),
                //         //   child: Image.network(
                //         //       fit: BoxFit.cover,
                //         //       '${userreview[index]['testimonial_image']}'),
                //         // ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void Fetch_Tour() async {
    var url = Uri.https('bestvoyage.co.in', 'api/top-tour-list.php');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    setState(() {
      mydata = mymap['data'];
    });
  }

  // ignore: non_constant_identifier_names
  void Fetch_Tour_Type() async {
    var url = Uri.https('bestvoyage.co.in', 'api/tour-type.php');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> tourtypemap = json.decode(response.body);
    setState(() {
      mytourtype = tourtypemap['data'];
    });
  }

  // ignore: non_constant_identifier_names
  void Fetch_Tour_Regions() async {
    var url = Uri.https('bestvoyage.co.in', 'api/regions-list.php');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> tourregions = json.decode(response.body);
    setState(() {
      myregions = (tourregions['data'] as List).sublist(0, 4);
    });
  }

  void Fetch_Review() async {
    var url = Uri.https('bestvoyage.co.in', 'api/testimonials.php');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> review = json.decode(response.body);
    setState(() {
      userreview = review['data'];
    });
  }

  // void Slider_Image() async {
  //   var url = Uri.http('bestvoyage.co.in', 'api/slider-list.php');
  //   var response = await http.get(url);
  //   Map<String, dynamic> myimage = json.decode(response.body);
  //   setState(() {
  //     myimagelist = myimage['data'];
  //   });
  // }
}
