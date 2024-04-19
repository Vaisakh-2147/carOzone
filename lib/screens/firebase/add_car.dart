import 'dart:io';

import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/admin_panel.dart';
import 'package:car_o_zone/screens/firebase/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddcarScreen extends StatefulWidget {
  const AddcarScreen({super.key});

  @override
  State<AddcarScreen> createState() => __AddcarScreenState();
}

class __AddcarScreenState extends State<AddcarScreen> {
  String? imageUrl;
  String? _cars;
  String? _selectedFuelType;
  String? _selectedSeatingCapacity;
  String? _selectedSafetyrating;

  final carnameController = TextEditingController();
  final caryearController = TextEditingController();
  final carprizeController = TextEditingController();
  final brandController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final carfueltypeController = TextEditingController();
  final cartransmissionController = TextEditingController();
  final carenginesizeController = TextEditingController();
  final carmileageController = TextEditingController();
  final carsafetyratingController = TextEditingController();
  final cargroundclearanceController = TextEditingController();
  final avgwaitingperiodController = TextEditingController();
  final carseatingcapacityController = TextEditingController();
  final carsizeController = TextEditingController();
  final carfueltankController = TextEditingController();
  final youtubeurl1Controller = TextEditingController();
  final youtubeurl2Controller = TextEditingController();
  final youtubeurl3Controller = TextEditingController();
  final pricerangeController = TextEditingController();

  String? _selectedPriceRange;
  final List<String> _priceRanges = [
    '5 - 10 Lakhs',
    '10 - 25 Lakhs',
    '25 - 50 Lakhs',
    '50 - 70 Lakhs',
    '70 - 90 Lakhs',
    '90 - 1.5 crore'
  ];

  Future<void> _pickCars() async {
    final imagePicker2 = ImagePicker();
    final pickedcars =
        await imagePicker2.pickImage(source: ImageSource.gallery);

    setState(() {
      _cars = pickedcars!.path;
    });
  }

  void _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        caryearController.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (context) => const AdminpanelScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 300, left: 10),
              ),
              subtitle('Add brand', 13),
              titleLogo()
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        subtitle('Cars', 13),
                        const SizedBox(height: 15),
                        customAddbrandPicker(image: _cars, onTap: _pickCars),
                        if (_cars == null)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Please select an image',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subtitle('carname', 13),
                              textFormFieldWidget(
                                  controller: carnameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car name';
                                    }
                                    return null;
                                  },
                                  hintText: 'car name'),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('carprize', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: carprizeController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter car prize';
                                            }
                                            return null;
                                          },
                                          hintText: 'car prize',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car year', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: TextButton(
                                          onPressed: () {
                                            _selectYear(context);
                                          },
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                                    const Size.fromHeight(61)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                  color: customBorderColor(),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromARGB(
                                                        255, 214, 180, 180)),
                                          ),
                                          child: Text(
                                            caryearController.text.isEmpty
                                                ? 'Select Year'
                                                : caryearController.text,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('brand name', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: brandController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter brandname';
                                            }
                                            return null;
                                          },
                                          hintText: 'brand name',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car fueltype', 15),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        color: const Color.fromARGB(
                                            217,
                                            217,
                                            217,
                                            217), // Set background color of the container
                                        child: SizedBox(
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _selectedFuelType,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedFuelType = newValue!;
                                              });
                                            },
                                            items: <String>[
                                              'Petrol',
                                              'Diesel',
                                              'Electric',
                                              'Hybrid',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            decoration: const InputDecoration(
                                              hintText: 'car fueltype',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please car fueltype';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car transmission', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: cartransmissionController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter cartransmission';
                                            }
                                            return null;
                                          },
                                          hintText: 'car transmission',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car enginesize', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: carenginesizeController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter car enginesize';
                                            }
                                            return null;
                                          },
                                          hintText: 'car enginesize',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car mileage', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: carmileageController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter carmileage';
                                            }
                                            return null;
                                          },
                                          hintText: 'carmileage',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car fueltype', 15),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        color: const Color.fromARGB(
                                            217, 217, 217, 217),
                                        child: SizedBox(
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _selectedSafetyrating,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedSafetyrating =
                                                    newValue!;
                                              });
                                            },
                                            items: <String>[
                                              '1 star',
                                              '2 star',
                                              '3 star',
                                              '4 star',
                                              '5 star',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            decoration: const InputDecoration(
                                              hintText: 'safetyrating',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select safetyrating';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('groundclearence', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller:
                                              cargroundclearanceController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter groundclearence';
                                            }
                                            return null;
                                          },
                                          hintText: 'groundclearance',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('seatingcapacity', 15),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        color: const Color.fromARGB(
                                            217, 217, 217, 217),
                                        child: SizedBox(
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _selectedSeatingCapacity,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedSeatingCapacity =
                                                    newValue!;
                                              });
                                            },
                                            items: <String>[
                                              '5 people',
                                              '7 people',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            decoration: const InputDecoration(
                                              hintText: 'seatingcapacity',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select seatingcapacity';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car size', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: carsizeController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter carsize';
                                            }
                                            return null;
                                          },
                                          hintText: 'carsize',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      subtitle('car fueltank', 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42,
                                        child: textFormFieldWidget(
                                          controller: carfueltankController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter car fueltank';
                                            }
                                            return null;
                                          },
                                          hintText: 'car fueltank',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  subtitle('Price Range', 15),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .42,
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedPriceRange,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 202, 196, 196),
                                        border: OutlineInputBorder(),
                                      ),
                                      items: _priceRanges.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedPriceRange = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select a price range';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                              subtitle('YoutubeUrl 1', 13),
                              textFormFieldWidget(
                                  controller: youtubeurl1Controller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter youtube urls';
                                    }
                                    return null;
                                  },
                                  hintText: 'youtubeUrl'),
                              subtitle('YoutubeUrl 2', 13),
                              textFormFieldWidget(
                                  controller: youtubeurl2Controller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter youtube urls';
                                    }
                                    return null;
                                  },
                                  hintText: 'youtubeUrl'),
                              subtitle('YoutubeUrl 3', 13),
                              textFormFieldWidget(
                                  controller: youtubeurl3Controller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter youtube urls';
                                    }
                                    return null;
                                  },
                                  hintText: 'youtubeUrl'),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_cars == null ||
                                  carnameController.text.isEmpty ||
                                  carprizeController.text.isEmpty ||
                                  caryearController.text.isEmpty ||
                                  brandController.text.isEmpty ||
                                  carfueltypeController.text.isEmpty ||
                                  cartransmissionController.text.isEmpty ||
                                  carenginesizeController.text.isEmpty ||
                                  carmileageController.text.isEmpty ||
                                  carsafetyratingController.text.isEmpty ||
                                  cargroundclearanceController.text.isEmpty ||
                                  carseatingcapacityController.text.isEmpty ||
                                  carsizeController.text.isEmpty ||
                                  carfueltankController.text.isEmpty ||
                                  _selectedPriceRange == null ||
                                  youtubeurl1Controller.text.isEmpty ||
                                  youtubeurl2Controller.text.isEmpty ||
                                  youtubeurl3Controller.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Please fill in all the fields'),
                                ));
                              } else {
                                String uniqueFileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                    referenceRoot.child('cars');
                                Reference referenceImageToUpload =
                                    referenceDirImages.child(uniqueFileName);

                                try {
                                  await referenceImageToUpload
                                      .putFile(File(_cars!));
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                  await FirebaseFirestore.instance
                                      .collection('carDetails')
                                      .add({
                                    'cars': imageUrl,
                                    "carname": carnameController.text,
                                    "carprize": carprizeController.text,
                                    "caryear": caryearController.text,
                                    "brand": brandController.text.toLowerCase(),
                                    "fueltype": carfueltypeController.text,
                                    "transmission":
                                        cartransmissionController.text,
                                    "enginesize": carenginesizeController.text,
                                    "mileage": carmileageController.text,
                                    "safetyrating":
                                        carsafetyratingController.text,
                                    "groundclearance":
                                        cargroundclearanceController.text,
                                    "seatingcapacity":
                                        carseatingcapacityController.text,
                                    "carsize": carsizeController.text,
                                    "carfueltank": carfueltankController.text,
                                    "priceRange": _selectedPriceRange,
                                    "video 1": youtubeurl1Controller.text,
                                    "video 2": youtubeurl2Controller.text,
                                    "video 3": youtubeurl3Controller.text,
                                  });

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Data added successfully'),
                                  ));

                                  carnameController.clear();
                                  carprizeController.clear();
                                  caryearController.clear();
                                  brandController.clear();
                                  carfueltypeController.clear();
                                  cartransmissionController.clear();
                                  carenginesizeController.clear();
                                  carmileageController.clear();
                                  carsafetyratingController.clear();
                                  cargroundclearanceController.clear();
                                  carseatingcapacityController.clear();
                                  carsizeController.clear();
                                  carfueltankController.clear();
                                  pricerangeController.clear();
                                  youtubeurl1Controller.clear();
                                  youtubeurl2Controller.clear();
                                  youtubeurl3Controller.clear();
                                  setState(() {
                                    _cars = null;
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
