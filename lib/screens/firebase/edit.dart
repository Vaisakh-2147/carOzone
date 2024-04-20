import 'dart:io';

import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/admin_panel.dart';
import 'package:car_o_zone/screens/firebase/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.carsSnapshot,
  });

  final DocumentSnapshot carsSnapshot;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
  final cartransmissionController = TextEditingController();
  final carenginesizeController = TextEditingController();
  final carmileageController = TextEditingController();
  final cargroundclearanceController = TextEditingController();
  final avgraitingperiodController = TextEditingController();
  final carsizeController = TextEditingController();
  final carfueltankController = TextEditingController();
  final youtubeurl1Controller = TextEditingController();
  final youtubeurl2Controller = TextEditingController();
  final youtubeurl3Controller = TextEditingController();

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
  void initState() {
    super.initState();
    carnameController.text = widget.carsSnapshot['carname'];
    carprizeController.text = widget.carsSnapshot['carprize'];
    caryearController.text = widget.carsSnapshot['caryear'];
    carenginesizeController.text = widget.carsSnapshot['enginesize'];
    carfueltankController.text = widget.carsSnapshot['carfueltank'];
    carsizeController.text = widget.carsSnapshot['carsize'];
    cargroundclearanceController.text = widget.carsSnapshot['groundclearance'];
    carmileageController.text = widget.carsSnapshot['mileage'];
    cartransmissionController.text = widget.carsSnapshot['transmission'];
    brandController.text = widget.carsSnapshot['brand'];
    _selectedPriceRange = widget.carsSnapshot['priceRange'];
    _selectedFuelType = widget.carsSnapshot['fueltype'];
    _selectedSeatingCapacity = widget.carsSnapshot['seatingcapacity'];
    _selectedSafetyrating = widget.carsSnapshot['safetyrating'];
    youtubeurl1Controller.text = widget.carsSnapshot['video 1'];
    youtubeurl2Controller.text = widget.carsSnapshot['video 2'];
    youtubeurl3Controller.text = widget.carsSnapshot['video 3'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(
                  builder: (context) => const AdminpanelScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 3),
              child: subtitle('Edit cars', 13),
            ),
            titleLogo(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              subtitle('Cars', 13),
              const SizedBox(height: 15),
              customUpdatebrandPicker(
                fileImage: _cars,
                networkImage: widget.carsSnapshot['cars'],
                onTap: _pickCars,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('carprize', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: carprizeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car year', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: TextButton(
                                onPressed: () {
                                  _selectYear(context);
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size.fromHeight(61)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: customBorderColor(),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 214, 180, 180)),
                                ),
                                child: Text(
                                  caryearController.text.isEmpty
                                      ? 'Select Year'
                                      : caryearController.text,
                                  style: const TextStyle(color: Colors.black),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('brand name', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: brandController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car fueltype', 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              color: const Color.fromARGB(217, 217, 217, 217),
                              child: SizedBox(
                                child: DropdownButtonFormField<String>(
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
                                    if (value == null || value.isEmpty) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car transmission', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: cartransmissionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car enginesize', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: carenginesizeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car mileage', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: carmileageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car fueltype', 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              color: const Color.fromARGB(217, 217, 217, 217),
                              child: SizedBox(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedSafetyrating,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedSafetyrating = newValue!;
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
                                    if (value == null || value.isEmpty) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('groundclearence', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: cargroundclearanceController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('seatingcapacity', 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              color: const Color.fromARGB(217, 217, 217, 217),
                              child: SizedBox(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedSeatingCapacity,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedSeatingCapacity = newValue!;
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
                                    if (value == null || value.isEmpty) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car size', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: carsizeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car fueltank', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .42,
                              child: textFormFieldWidget(
                                controller: carfueltankController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                          width: MediaQuery.of(context).size.width * .42,
                          child: DropdownButtonFormField<String>(
                            value: _selectedPriceRange,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 202, 196, 196),
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
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      print('link;$_cars');
                      if (_cars != null) {
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('cars');
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          await referenceImageToUpload.putFile(File(_cars!));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          print(
                              'imageUrl: $imageUrl'); // Debugging statement to check the image URL
                        } catch (e) {
                          print(
                              'Error uploading image: $e'); // Handle any errors during image upload
                          return; // Exit the function if image upload fails
                        }
                      }

                      try {
                        await FirebaseFirestore.instance
                            .collection('carDetails')
                            .doc(widget.carsSnapshot.id)
                            .update({
                          'cars': imageUrl ?? widget.carsSnapshot['cars'],
                          "carname": carnameController.text,
                          "carprize": carprizeController.text,
                          "caryear": caryearController.text,
                          "mileage": carmileageController.text,
                          "transmission": cartransmissionController.text,
                          "groundclearance": cargroundclearanceController.text,
                          "carfueltank": carfueltankController.text,
                          "brand": brandController.text,
                          "priceRange": _selectedPriceRange,
                          "safetyrating": _selectedSafetyrating,
                          "seatingcapacity": _selectedSeatingCapacity,
                          "fueltype": _selectedFuelType,
                          "video 1": youtubeurl1Controller.text,
                          "video 2": youtubeurl2Controller.text,
                          "video 3": youtubeurl3Controller.text,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Data updated successfully')));
                        _cars = null; // Reset the selected image after update
                      } catch (e) {
                        print(
                            'Error updating data: $e'); // Handle any errors during Firestore update
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to update data')));
                      }
                    },
                    child: const Text("UpdateCars"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
