import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/hive/model/car_comparison.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({
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
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _carDataStream;

  @override
  void initState() {
    super.initState();
    _carDataStream = _subscribeToCarData();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _subscribeToCarData() {
    return FirebaseFirestore.instance
        .collection('carDetails')
        .doc(widget.carId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: Center(child: titleLogo()),
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _carDataStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error: {snapshot.error}'));
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Data not found'));
              }

              final carData = snapshot.data!.data();
              final secondImageUrl = carData!['cars'];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Text(
                        'Comparison',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 125,
                              color: const Color.fromARGB(255, 239, 237, 237),
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 190,
                              height: 125,
                              color: const Color.fromARGB(255, 239, 237, 237),
                              child: secondImageUrl.isEmpty
                                  ? const Placeholder(
                                      fallbackHeight: 125,
                                      fallbackWidth: 190,
                                    )
                                  : Image.network(secondImageUrl),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width: 190,
                            height: 40,
                            color: const Color.fromARGB(255, 239, 237, 237),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.text,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Container(
                            width: 190,
                            height: 40,
                            color: const Color.fromARGB(255, 239, 237, 237),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                carData['carname'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('specifications',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.prize,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['carprize'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Fuel Type',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.fueltype,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['fueltype'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Transmission',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.transmission,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['transmission'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Enginesize',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.enginesize,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['enginesize'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Safety rating',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.safetyrating,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['safetyrating'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Seating Capacity',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.seatingcapacity,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['seatingcapacity'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Fuel Tank',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.carfueltank,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['carfueltank'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Ground Clearence',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.groundclearance,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['groundclearance'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                            child: const Text(
                              'Mileage',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 38,
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      0.5,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: .5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        widget.mileage,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        carData['mileage'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 38,
                            color: const Color.fromARGB(255, 214, 220, 223),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final carData = await FirebaseFirestore.instance
                              .collection('carDetails')
                              .doc(widget.carId)
                              .get();

                          final secondImageUrl = carData['cars'];
                          final secondText = carData['carname'];
                          final secondPrize = carData['carprize'];
                          final secondFueltype = carData['fueltype'];
                          final secondTransmission = carData['transmission'];
                          final secondEnginesize = carData['enginesize'];
                          final secondMileage = carData['mileage'];
                          final secondSafetyrating = carData['safetyrating'];
                          final secondGroundclearance =
                              carData['groundclearance'];
                          final secondSeatingcapacity =
                              carData['seatingcapacity'];
                          final secondCarfueltank = carData['carfueltank'];
                          final secondCarsize = carData['carsize'];

                          final comparisonBox =
                              await Hive.openBox<CarComparison>(
                                  'car_comparison');
                          final comparisonData = CarComparison(
                            carId: widget.carId,
                            imageUrl: widget.imageUrl,
                            text: widget.text,
                            prize: widget.prize,
                            fueltype: widget.fueltype,
                            transmission: widget.transmission,
                            enginesize: widget.enginesize,
                            mileage: widget.mileage,
                            safetyrating: widget.safetyrating,
                            groundclearance: widget.groundclearance,
                            seatingcapacity: widget.seatingcapacity,
                            carsize: widget.carsize,
                            carfueltank: widget.carfueltank,
                            secondImageUrl: secondImageUrl,
                            secondText: secondText,
                            secondPrize: secondPrize,
                            secondFueltype: secondFueltype,
                            secondTransmission: secondTransmission,
                            secondEnginesize: secondEnginesize,
                            secondMileage: secondMileage,
                            secondSafetyrating: secondSafetyrating,
                            secondGroundclearance: secondGroundclearance,
                            secondSeatingcapacity: secondSeatingcapacity,
                            secondCarfueltank: secondCarfueltank,
                            secondCarsize: secondCarsize,
                          );
                          comparisonBox.add(comparisonData);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Comparison data saved!'),
                            ),
                          );
                        },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
