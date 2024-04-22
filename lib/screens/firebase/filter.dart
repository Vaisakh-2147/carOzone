import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String _selectedPrice;
  late String _selectedFuelType;
  late String _selectedSeatingCapacity;
  late Stream<QuerySnapshot>? _carDetailsStream;
  List<DocumentSnapshot> _filteredDocuments = [];

  final List<String> priceOptions = [
    '5 - 10 Lakhs',
    '10 - 25 Lakhs',
    '25 - 50 Lakhs',
    '50 - 70 Lakhs',
    '70 - 90 Lakhs',
    '90 - 1.5 crore',
  ];

  final List<String> fuelTypeOptions = [
    'Diesel',
    'Petrol',
    'Hybrid',
    'Ev',
  ];

  final List<String> seatingCapacityOptions = [
    '5 people',
    '7 people',
  ];

  @override
  void initState() {
    super.initState();
    _selectedPrice = '';
    _selectedFuelType = '';
    _selectedSeatingCapacity = '';
    _carDetailsStream = null;
  }

  Future<void> _getFilteredDocuments() async {
    CollectionReference carDetailsRef =
        FirebaseFirestore.instance.collection('carDetails');

    Query filteredQuery = carDetailsRef;

    if (_selectedPrice.isNotEmpty && _selectedPrice != "None") {
      filteredQuery =
          filteredQuery.where('priceRange', isEqualTo: _selectedPrice);
    }

    if (_selectedFuelType.isNotEmpty && _selectedFuelType != "None") {
      filteredQuery =
          filteredQuery.where('fueltype', isEqualTo: _selectedFuelType);
    }

    if (_selectedSeatingCapacity.isNotEmpty &&
        _selectedSeatingCapacity != "None") {
      filteredQuery = filteredQuery.where('seatingcapacity',
          isEqualTo: _selectedSeatingCapacity);
    }

    QuerySnapshot querySnapshot = await filteredQuery.get();
    setState(() {
      _filteredDocuments = querySnapshot.docs;
      _carDetailsStream = Stream.value(querySnapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          'Filter',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 243, 243, 243),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildFilterDropdown('Price', priceOptions, (value) {
              setState(() {
                _selectedPrice = value;
              });
            }, _selectedPrice),
            _buildFilterDropdown('Fuel Type', fuelTypeOptions, (value) {
              setState(() {
                _selectedFuelType = value;
              });
            }, _selectedFuelType),
            _buildFilterDropdown('Seating Capacity', seatingCapacityOptions,
                (value) {
              setState(() {
                _selectedSeatingCapacity = value;
              });
            }, _selectedSeatingCapacity),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _getFilteredDocuments,
              child: const Text('Apply Filter'),
            ),
            if (_carDetailsStream != null)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _carDetailsStream!,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    List<DocumentSnapshot> filteredDocuments =
                        _filteredDocuments.isNotEmpty
                            ? _filteredDocuments
                            : documents;

                    if (filteredDocuments.isEmpty) {
                      return Center(
                        child: Text(
                          'No results found.',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 81, 81, 81),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredDocuments.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = filteredDocuments[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 370,
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
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
                                    data['fueltype'],
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
                                Stack(
                                  children: [
                                    Positioned(
                                      bottom: 5,
                                      right: 7,
                                      child: Text(
                                        data['carprize'],
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 15),
                                    Stack(
                                      children: [
                                        GestureDetector(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, top: 20),
                                              child: CachedNetworkImage(
                                                imageUrl: data['cars'],
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                width: 250,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                        const SizedBox(height: 15),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String title, List<String> options,
      Function(String) onChanged, String selectedValue) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                menuMaxHeight: 200,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 40,
                iconEnabledColor: Colors.black,
                elevation: 40,
                underline: Container(),
                padding: EdgeInsets.zero,
                value: selectedValue.isNotEmpty ? selectedValue : null,
                // ignore: unnecessary_null_comparison
                onChanged: onChanged == null
                    ? null
                    : (String? newValue) {
                        if (newValue == "None") {
                          newValue = '';
                        }
                        print("Selected Value: $newValue");
                        onChanged(newValue!);
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                items: ['None', ...options].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            )
          ]),
        ));
  }
}
