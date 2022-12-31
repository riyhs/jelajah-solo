import 'dart:ui';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:tempat_wisata/source.dart';

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
    return DraggableHome(
      title: const Text("Detail"),
      headerWidget: headerWidget(context, place),
      body: [
        detailPlace(context, place),
      ],
      fullyStretchable: false,
      backgroundColor: Colors.white,
      appBarColor: Colors.black,
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
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: Colors.white),
      ),
    ),
  );
}

Widget detailPlace(BuildContext context, TourismPlace place) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
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
            Text(place.name),
            Text(place.location),
          ],
        ),
      ),
      Column(
        children: [
          const Text(""),
          Text(place.ticketPrice),
        ],
      ),
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
                color: Colors.black.withOpacity(0.25),
              )
            ],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("test"),
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
      const Text("Deskripsi"),
      Text(place.description),
    ],
  );
}

Widget mapButton(BuildContext context) {
  return SizedBox(
    height: 30,
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: const Text(
        "Detail",
        style: TextStyle(
          color: Color(0xffffffff),
        ),
      ),
    ),
  );
}