import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TourImagesDetails extends StatefulWidget {
  const TourImagesDetails({super.key});

  @override
  State<TourImagesDetails> createState() => _TourImagesDetailsState();
}

class _TourImagesDetailsState extends State<TourImagesDetails> {
  List mytourimage = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_tour_images();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // ignore: unnecessary_null_comparison
      body: mytourimage == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mytourimage.length,
              itemBuilder: (context, index) {
                // var images = mytourimage[index]['tour_images'];
                return Image.network(
                  mytourimage[index].toString(),
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }),
    );
  }

  void fetch_tour_images() async {
    try {
      var url =
          Uri.https('bestvoyage.co.in', 'api/tour-details.php', {'id': '4'});
      var response = await http.get(url);
      print(response.statusCode);
      print(response.body);
      Map<String, dynamic> mymap = json.decode(response.body);
      setState(() {
        if (mymap['flag'] == '1') {
          mytourimage = mymap['tour_images'];
        } else {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
