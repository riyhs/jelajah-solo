import 'dart:ui';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:tempat_wisata/source.dart';
import 'detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: "Draggable Home",
    home: HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: const Text("Draggable Home"),
      headerWidget: headerWidget(context),
      body: [
        listView(),
      ],
      fullyStretchable: false,
      backgroundColor: Colors.white,
      appBarColor: Colors.teal,
    );
  }
}

Widget headerWidget(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.blueAccent,
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
        ColorFilter.mode(Colors.black45, BlendMode.darken),
        image: AssetImage("assets/images/cloudySky.jpg"),
      ),
    ),
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        "Ojo Lali Hiling",
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: Colors.white),
      ),
    ),
  );
}

ListView listView() {
  return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tourismPlaceList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final place = tourismPlaceList[index];
        return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: listCard(context, place)
        );
      }
  );
}

Widget listCard(BuildContext context, TourismPlace place) {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blueAccent,
      image: DecorationImage(
          image: NetworkImage(place.imageUrls[1]),
          fit: BoxFit.cover),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: blurredSection(context, place),
    ),
  );
}

Widget blurredSection(BuildContext context, TourismPlace place) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7,
              sigmaY: 7,
            ),
            child: const SizedBox(
              height: 70,
              width: 360,
            ),
          ),
          Container(
            height: 70,
            width: 360,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                )
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.2)
                ],
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
              child: Row(
                // === Content ===
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(place.name),
                        Text(place.location),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      detailButton(context, place.id),
                    ],
                  ),
                ],
                // === End Content ===
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget detailButton(BuildContext context, int id) {
  return SizedBox(
    height: 30,
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(index: id),
          ),
        );
      },
      child: const Text(
        "Detail",
        style: TextStyle(
          color: Color(0xffffffff),
        ),
      ),
    ),
  );
}