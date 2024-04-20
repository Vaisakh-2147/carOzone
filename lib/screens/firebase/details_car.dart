import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/compare_cars.dart';
import 'package:car_o_zone/screens/hive/comment.dart';
import 'package:car_o_zone/screens/videos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailcarScreen extends StatefulWidget {
  const DetailcarScreen(
      {super.key,
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
      required this.carfueltank});
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
  State<DetailcarScreen> createState() => _DetailcarScreenState();
}

User? user = FirebaseAuth.instance.currentUser;

class _DetailcarScreenState extends State<DetailcarScreen> {
  bool isFavorite = false;
  String? currentCarId;
  double _rating = 0.0;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _submitRating() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ratings')
          .where('carId', isEqualTo: widget.carId)
          .where('userEmail', isEqualTo: user!.email)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      await FirebaseFirestore.instance.collection('ratings').add({
        'carId': widget.carId,
        'userEmail': user!.email,
        'rating': _rating,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Rating submitted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error submitting rating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit rating. Please try again later'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    _loadRating();
  }

  void _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('FAVORITE') ?? false;
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('favorite')
        .where('carID', isEqualTo: widget.carId)
        .where('useremail', isEqualTo: user!.email)
        .get();

    setState(() {
      isFavorite = querySnapshot.docs.isNotEmpty;
    });
  }

  void _toggleFavoriteStatus() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('FAVORITE', isFavorite);

    if (isFavorite) {
      await FirebaseFirestore.instance.collection('favorite').add({
        'carID': widget.carId,
        'useremail': user!.email,
        'carImage': widget.imageUrl,
        'carPrice': widget.prize,
        'carfueltype': widget.fueltype,
        'carname': widget.text,
      });
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorite')
          .where('carID', isEqualTo: widget.carId)
          .where('useremail', isEqualTo: user!.email)
          .where('carImage', isEqualTo: widget.imageUrl)
          .where('carPrice', isEqualTo: widget.prize)
          .where('carfueltype', isEqualTo: widget.fueltype)
          .where('carname', isEqualTo: widget.text)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
      setState(() {
        isFavorite = false;
      });
    }
  }

  void _loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedRating = prefs.getDouble('RATING') ?? 0.0;
    setState(() {
      _rating = savedRating;
    });
  }

  void _saveRating(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('RATING', rating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 14, 82),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 14, 82),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.imageUrl.isEmpty
                      ? const Placeholder(
                          fallbackHeight: 130,
                          fallbackWidth: 250,
                        )
                      : Image.network(widget.imageUrl),
                ),
                Positioned(
                  left: 10,
                  bottom: 6,
                  child: IconButton(
                    onPressed: _toggleFavoriteStatus,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 37,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  right: 7,
                  top: 10,
                  child: Text(
                    widget.text,
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
                  top: 65,
                  right: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.vertical,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 25,
                        glowColor: Colors.amber,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                          _saveRating(rating);
                        },
                      ),
                      const SizedBox(height: 10),

                      // Adjust as needed
                      ElevatedButton(
                        onPressed: () {
                          _submitRating();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber), // Set background color
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(100, 30)),
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text(
                "Key specification",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            buildSpecificationList(
              price: widget.prize,
              fueltype: widget.fueltype,
              transmission: widget.transmission,
              enginesize: widget.enginesize,
              mileage: widget.mileage,
              safetyrating: widget.safetyrating,
              groundclearance: widget.groundclearance,
              seatingcapacity: widget.seatingcapacity,
              carsize: widget.carsize,
              fueltank: widget.carfueltank,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CommentScreen(carId: widget.carId)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Comments',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _fetchCarNames,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text(
                        'Comparison',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoScreen(
                                carName: widget.text,
                              )));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10)),
                    child: const Text(
                      'Videos',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _fetchCarNames() async {
    List<String> carNames = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('carDetails').get();
    String currentCarName = widget.text;
    querySnapshot.docs.forEach((doc) {
      String carName = doc['carname'];
      if (carName != currentCarName) {
        carNames.add(doc['carname']);
      }
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Car Names'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: carNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(carNames[index]),
                onTap: () async {
                  String selectedCarName = carNames[index];

                  DocumentSnapshot selectedCarSnapshot = await FirebaseFirestore
                      .instance
                      .collection('carDetails')
                      .where('carname', isEqualTo: selectedCarName)
                      .get()
                      .then((querySnapshot) => querySnapshot.docs.first);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompareScreen(
                        carId: selectedCarSnapshot.id,
                        imageUrl: widget.imageUrl,
                        text: widget.text,
                        transmission: widget.transmission,
                        carfueltank: widget.carfueltank,
                        carsize: widget.carsize,
                        fueltype: widget.fueltype,
                        mileage: widget.mileage,
                        groundclearance: widget.groundclearance,
                        seatingcapacity: widget.seatingcapacity,
                        prize: widget.prize,
                        safetyrating: widget.safetyrating,
                        enginesize: widget.enginesize,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 214, 153, 39),
      ),
    );
  }
}

Widget buildSpecificationList({
  required String price,
  required String fueltype,
  required String transmission,
  required String enginesize,
  required String mileage,
  required String safetyrating,
  required String groundclearance,
  required String seatingcapacity,
  required String carsize,
  required String fueltank,
}) {
  List<IconData> icons = [
    Icons.monetization_on,
    Icons.local_gas_station,
    Icons.settings,
    Icons.directions_car,
    Icons.speed,
    Icons.security,
    Icons.vertical_align_bottom,
    Icons.event_seat,
    Icons.aspect_ratio,
    Icons.local_gas_station,
  ];

  List<String> titles = [
    "price",
    "fuel type",
    "transmission",
    "enginesize",
    "mileage",
    "safety rating",
    "ground clearance",
    "seating apacity",
    "car size",
    "fuel tank",
  ];

  List<String> values = [
    price,
    fueltype,
    transmission,
    enginesize,
    mileage,
    safetyrating,
    groundclearance,
    seatingcapacity,
    carsize,
    fueltank,
  ];
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) => Container(),
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return buildListItem(icons[index], titles[index], values[index]);
    },
  );
}

Widget buildListItem(IconData iconData, String title, String value) {
  return Container(
    color: Colors.grey[300],
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
      leading: Icon(iconData),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
