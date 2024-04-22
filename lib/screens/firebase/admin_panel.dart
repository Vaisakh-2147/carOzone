import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/add_brand.dart';
import 'package:car_o_zone/screens/firebase/add_car.dart';
import 'package:car_o_zone/screens/firebase/edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminpanelScreen extends StatefulWidget {
  const AdminpanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminpanelScreen> createState() => _AdminpanelScreenState();
}

class _AdminpanelScreenState extends State<AdminpanelScreen> {
  final searchController = TextEditingController();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              subtitle('Admin', 13),
              titleLogo(),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 60,
              child: TextField(
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
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 150,
            child: FloatingActionButton.extended(
              heroTag: 'btn1',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddbrandScreen(),
                ));
              },
              label: Row(
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  subtitle('Add brand', 19, textColor: Colors.black),
                ],
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: const Color.fromARGB(255, 33, 243, 240),
              elevation: 6.0,
            ),
          ),
          SizedBox(
            width: 150,
            child: FloatingActionButton.extended(
              heroTag: 'btn2',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddcarScreen()));
              },
              label: Row(
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  subtitle('Add car', 19, textColor: Colors.black),
                ],
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: const Color.fromARGB(255, 33, 243, 240),
              elevation: 6.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('carBrands')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot carBrandSnapshot =
                              snapshot.data!.docs[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 90,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.network(
                                        carBrandSnapshot['CarBrand'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              Text(
                                carBrandSnapshot['brandname'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  print(carBrandSnapshot.id);
                                  await FirebaseFirestore.instance
                                      .collection('carBrands')
                                      .doc(carBrandSnapshot.id)
                                      .delete();
                                  setState(() {
                                    _showSnackbar('Brand deleted successfully');
                                    print('Deleted item at index $index');
                                  });
                                },
                                color: Colors.white,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('carDetails')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot carsSnapshot =
                            snapshot.data!.docs[index];
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    width: 370,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: carsSnapshot['cars'],
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        width: 250,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: IconButton(
                                onPressed: () async {
                                  print(carsSnapshot.id);
                                  await FirebaseFirestore.instance
                                      .collection('carDetails')
                                      .doc(carsSnapshot.id)
                                      .delete();
                                  setState(
                                    () {
                                      _showSnackbar('Car deleted successfully');
                                      print('Deleted item at index $index');
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                iconSize: 30,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                        carsSnapshot: carsSnapshot,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                iconSize: 30,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
