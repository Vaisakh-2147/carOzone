import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/functions/homepage_functions.dart';
import 'package:car_o_zone/screens/firebase/details_car.dart';
import 'package:car_o_zone/screens/firebase/filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String selectedBrand = '';
  final searchController = TextEditingController();
  String name = '';
  List<QueryDocumentSnapshot>? searchResults;
  bool _isFavorite = false;

  Stream<bool> isFavorite(String carId) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return FirebaseFirestore.instance
          .collection('favorite')
          .where('carID', isEqualTo: carId)
          .where('useremail', isEqualTo: user.email)
          .snapshots()
          .map((snapshot) => snapshot.docs.isNotEmpty);
    } else {
      return Stream.value(false);
    }
  }

  Stream<double> getRatingStream(String carId) {
    return FirebaseFirestore.instance
        .collection('ratings')
        .where('carId', isEqualTo: carId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        double totalRating = 0;
        for (final doc in snapshot.docs) {
          totalRating += doc['rating'] as double;
        }
        return totalRating / snapshot.docs.length;
      } else {
        return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('selectedbrand: $selectedBrand');
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      backgroundColor: const Color.fromARGB(255, 60, 14, 82),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 60, 14, 82),
            leading: Container(
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              constraints: const BoxConstraints(
                minHeight: 80.0,
                minWidth: 150.0,
                maxHeight: 120.0,
                maxWidth: 250.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                color: Colors.black,
                icon: const Icon(
                  Icons.menu,
                  size: 32,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: titleLogo(),
            ),
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 65),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: customBorderColor(),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(220, 237, 14, 40),
                        ),
                        labelText: "Search...",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        fillColor: customBlueColor(),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 251, 252, 251),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 21),
                        child: Text(
                          "Trending Brands",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 200),
                      GestureDetector(
                        child: Image.asset('Assets/images/filters.png',
                            width: 30, height: 30),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const FilterScreen()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('carBrands')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 75,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot carBrandSnapshot =
                                    snapshot.data!.docs[index];
                                bool isSelected = selectedBrand ==
                                    carBrandSnapshot['brandname']
                                        .toString()
                                        .toLowerCase()
                                        .trim();
                                return Row(
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedBrand =
                                                  carBrandSnapshot['brandname']
                                                      .toString()
                                                      .toLowerCase()
                                                      .trim();
                                            });
                                            print(
                                                'selectedbrand $selectedBrand');
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Colors.blueAccent
                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: CachedNetworkImage(
                                                imageUrl: carBrandSnapshot[
                                                    'CarBrand'],
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          carBrandSnapshot['brandname'],
                                          style: TextStyle(
                                              color: isSelected
                                                  ? Colors.blueAccent
                                                  : Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              },
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center();
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Popular cars",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBrand = '';
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBrand = '';
                                searchController.clear();
                                name = '';
                              });
                            },
                            child: const Text(
                              'View all',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10),
            sliver: StreamBuilder(
              stream: selectedBrand.isEmpty
                  ? FirebaseFirestore.instance
                      .collection('carDetails')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('carDetails')
                      .where('brand', isEqualTo: selectedBrand)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter();
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No data available'),
                    ),
                  );
                } else {
                  List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                  searchResults = documents
                      .where((search) =>
                          (selectedBrand.isEmpty ||
                              selectedBrand.contains(
                                  search['brand'].toString().toLowerCase())) &&
                          (name.isEmpty ||
                              search['carname']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())))
                      .toList();

                  if (searchResults!.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No car available'),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        DocumentSnapshot carsSnapshot = searchResults![index];

                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailcarScreen(
                                    carId: carsSnapshot.id,
                                    imageUrl: carsSnapshot['cars'],
                                    text: carsSnapshot['carname'],
                                    prize: carsSnapshot['carprize'],
                                    carfueltank: carsSnapshot['carfueltank'],
                                    carsize: carsSnapshot['carsize'],
                                    mileage: carsSnapshot['mileage'],
                                    groundclearance:
                                        carsSnapshot['groundclearance'],
                                    seatingcapacity:
                                        carsSnapshot['seatingcapacity'],
                                    safetyrating: carsSnapshot['safetyrating'],
                                    fueltype: carsSnapshot['fueltype'],
                                    transmission: carsSnapshot['transmission'],
                                    enginesize: carsSnapshot['enginesize'],
                                  ),
                                ),
                              );
                            },
                            child: StreamBuilder<bool>(
                                stream: isFavorite(carsSnapshot.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    bool isFav = snapshot.data ?? false;
                                    _isFavorite = isFav;

                                    return Column(
                                      children: [
                                        Container(
                                          width: 370,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 254, 253, 253),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Stack(children: [
                                            Positioned(
                                              left: 10,
                                              bottom: 6,
                                              child: Icon(
                                                Icons.favorite,
                                                color: _isFavorite
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 30,
                                              ),
                                            ),
                                            Positioned(
                                              right: 7,
                                              top: 10,
                                              child: Text(
                                                carsSnapshot['carname'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 7,
                                              top: 33,
                                              child: Text(
                                                carsSnapshot['fueltype'],
                                                maxLines: 1,
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 15),
                                                Stack(
                                                  children: [
                                                    GestureDetector(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 40,
                                                            top: 20,
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                carsSnapshot[
                                                                    'cars'],
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                            width: 250,
                                                            height: 130,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailcarScreen(
                                                              carId:
                                                                  carsSnapshot
                                                                      .id,
                                                              imageUrl:
                                                                  carsSnapshot[
                                                                      'cars'],
                                                              text: carsSnapshot[
                                                                  'carname'],
                                                              prize: carsSnapshot[
                                                                  'carprize'],
                                                              carfueltank:
                                                                  carsSnapshot[
                                                                      'carfueltank'],
                                                              carsize:
                                                                  carsSnapshot[
                                                                      'carsize'],
                                                              mileage:
                                                                  carsSnapshot[
                                                                      'mileage'],
                                                              groundclearance:
                                                                  carsSnapshot[
                                                                      'groundclearance'],
                                                              seatingcapacity:
                                                                  carsSnapshot[
                                                                      'seatingcapacity'],
                                                              safetyrating:
                                                                  carsSnapshot[
                                                                      'safetyrating'],
                                                              fueltype:
                                                                  carsSnapshot[
                                                                      'fueltype'],
                                                              transmission:
                                                                  carsSnapshot[
                                                                      'transmission'],
                                                              enginesize:
                                                                  carsSnapshot[
                                                                      'enginesize'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(height: 15),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 7,
                                              child: Text(
                                                carsSnapshot['carprize'],
                                                maxLines: 1,
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 7,
                                              child: StreamBuilder<double>(
                                                  stream: getRatingStream(
                                                      carsSnapshot.id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Container();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      final double rating =
                                                          snapshot.data ?? 0;

                                                      int filledStars =
                                                          rating.round();
                                                      print('Rating: $rating');
                                                      print(
                                                          'Filled stars: $filledStars');

                                                      return Row(
                                                        children: List.generate(
                                                            5, (index) {
                                                          Color starColor =
                                                              index < filledStars
                                                                  ? Colors
                                                                      .yellow
                                                                  : Colors.grey;
                                                          print(
                                                              'Star $index color: $starColor');
                                                          return Icon(
                                                              Icons.star,
                                                              color: starColor);
                                                        }),
                                                      );
                                                    }
                                                  }),
                                            )
                                          ]),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  }
                                }));
                      },
                      childCount: searchResults!.length,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
