import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:tempat_wisata/source.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    TourismPlace place = tourismPlaceList[index];

    return MaterialApp(
      title: "Draggable Home",
      home: DetailPage(place: place),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.place});

  final TourismPlace place;

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return DraggableHome(
          title: const Text("Detail"),
          headerWidget: headerWidget(context, place),
          body: [
            detailPlace(context, place),
            const SizedBox(height: 16,),
            imageSlider(place),
            const SizedBox(height: 16,),
            mapButton(context, place),
          ],
          fullyStretchable: false,
          backgroundColor: Colors.white,
          appBarColor: Colors.black,
        );
    },
      maximumSize: const Size(400.0, 812.0),
      backgroundColor: Colors.grey,
    );
  }
}

Widget headerWidget(BuildContext context, TourismPlace place) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black45,
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
        const ColorFilter.mode(Colors.black45, BlendMode.darken),
        image: NetworkImage(place.imageUrls[1]),
      ),
    ),
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        place.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 42,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget detailPlace(BuildContext context, TourismPlace place) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            topDetailSection(place),
            const SizedBox(height: 24,),
            cardDetailSection(place),
            const SizedBox(height: 24,),
            aboutDetailSection(place),
          ],
        ),
      )
    ),
  );
}

Widget topDetailSection(TourismPlace place) {
  return Row(
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8,),
            Text(
              place.location,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget cardDetailSection(TourismPlace place) {
  return Row(
    children: [
      Expanded(
        child: Container(
          width: 300,
          height: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.40),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 18.0,
                            semanticLabel: 'Rating star',
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            place.rating.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        place.ticketPrice,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget aboutDetailSection(TourismPlace place) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Deskripsi",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8,),
      Text(
        place.description,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
    ],
  );
}

Widget mapButton(BuildContext context, TourismPlace place) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      width: 360,
      height: 42,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {
          _launchUrl(place.mapUrl);
        },
        child: const Text(
          "Buka di Google Map",
          style: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
      ),
    ),
  );
}

Widget imageSlider(TourismPlace place) {
  return CarouselSlider(
    options: CarouselOptions(height: 220.0),
    items: [0,1,2].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(place.imageUrls[i]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

Future<void> _launchUrl(String mapUrl) async {
  Uri url = Uri.parse(mapUrl);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
