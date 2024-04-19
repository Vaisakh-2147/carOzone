import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
    required this.carId,
    required this.imageUrl,
    required this.text,
    required this.prize,
    required this.fueltype,
    required this.transmission,
    required this.enginesize,
    required this.mileage,
    required this.safetyrating,
    required this.groundclearance,
    required this.seatingcapacity,
    required this.carsize,
    required this.carfueltank,
  }) : super(key: key);
  final String carId;
  final String imageUrl;
  final String text;
  final String prize;
  final String fueltype;
  final String transmission;
  final String enginesize;
  final String mileage;
  final String safetyrating;
  final String groundclearance;
  final String seatingcapacity;
  final String carsize;
  final String carfueltank;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 223, 223),
      appBar: AppBar(
        title: const Text('Favorite Cars'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favorite')
            .where('useremail', isEqualTo: user.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No favorite cars found.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 254, 253, 253),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 7,
                            top: 10,
                            child: Text(
                              data['carname'],
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
                              data['carfueltype'],
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40, top: 20),
                                      child: Image.network(
                                        data['carImage'],
                                        width: double.infinity,
                                        height: 130,
                                      ),
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
                              data['carPrice'],
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
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 6,
                    child: IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('favorite')
                            .doc(docs[index].id)
                            .delete();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('FAVORITE', true);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
