
import 'package:car_o_zone/functions/functions.dart';
import 'package:flutter/material.dart';

class SavecompareScreen extends StatefulWidget {
  final String imageUrl;
  final String secondImageUrl;
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
  final String secondText;
  final String secondCarfueltank;
  final String secondPrize;
  final String secondCarsize;
  final String secondSeatingcapacity;
  final String secondGroundclearance;
  final String secondSafetyrating;
  final String secondMileage;
  final String secondEnginesize;
  final String secondTransmission;
  final String secondFueltype;

  const SavecompareScreen({
    Key? key,
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
    required this.imageUrl,
    required this.secondImageUrl,
    required this.secondText,
    required this.secondCarfueltank,
    required this.secondPrize,
    required this.secondCarsize,
    required this.secondSeatingcapacity,
    required this.secondGroundclearance,
    required this.secondSafetyrating,
    required this.secondMileage,
    required this.secondEnginesize,
    required this.secondTransmission,
    required this.secondFueltype,
  }) : super(key: key);

  @override
  State<SavecompareScreen> createState() => _SavecompareScreenState();
}

class _SavecompareScreenState extends State<SavecompareScreen> {
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
        body: SingleChildScrollView(
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
                        child: Image.network(widget.imageUrl),
                      ),
                      const SizedBox(width: 2),
                      Container(
                        width: 190,
                        height: 125,
                        color: const Color.fromARGB(255, 239, 237, 237),
                        child: Image.network(widget.secondImageUrl),
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
                          widget.secondText,
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
                    //  Container(height: 30,width: double.infinity,color: Colors.white)
                    Container(
                      height: 38,
                      width: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            left: MediaQuery.of(context).size.width / 2 -
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.prize,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondPrize,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.fueltype,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondFueltype,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.transmission,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondTransmission,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.enginesize,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondEnginesize,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.safetyrating,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondSafetyrating,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.seatingcapacity,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondSeatingcapacity,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.carfueltank,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondCarfueltank,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.groundclearance,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondGroundclearance,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
                                0.5, // Adjust this value according to your divider thickness
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width:
                                  .5, // Adjust the width of the divider line as needed
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.mileage,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Adjust horizontal padding as needed
                                child: Text(
                                  widget.secondMileage,
                                  style: const TextStyle(
                                    color: Colors
                                        .black, // Adjust text color as needed
                                    fontSize: 16, // Adjust font size as needed
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
              ],
            ),
          ),
        ));
  }
}
