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
  final carnameController = TextEditingController();
  final caryearController = TextEditingController();
  final carprizeController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> _pickCars() async {
    final imagePicker2 = ImagePicker();
    final pickedcars =
        await imagePicker2.pickImage(source: ImageSource.gallery);

    setState(() {
      _cars = pickedcars!.path;
    });
  }

  @override
  void initState() {
    super.initState();
    carnameController.text = widget.carsSnapshot['carname'];
    carprizeController.text = widget.carsSnapshot['carprize'];
    caryearController.text = widget.carsSnapshot['caryear'];
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('car prize', 13),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                  controller: carprizeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car prize';
                                    }
                                    return null;
                                  },
                                  hintText: 'carprize'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            subtitle('car year', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                  controller: caryearController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car year';
                                    }
                                    return null;
                                  },
                                  hintText: 'caryear'),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            print('link;$_cars');
                            if (_cars != null) {
                              String uniqueFileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child('cars');
                              Reference referenceImageToUpload =
                                  referenceDirImages.child(uniqueFileName);

                              await referenceImageToUpload
                                  .putFile(File(_cars!));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                              print('imageUrl $imageUrl');
                            }
                            if (widget.carsSnapshot['cars'] != null) {
                              print(widget.carsSnapshot['cars']);

                              try {
                                await FirebaseFirestore.instance
                                    .collection('carDetails')
                                    .doc(widget.carsSnapshot.id)
                                    .update({
                                  'cars':
                                      imageUrl ?? widget.carsSnapshot['cars'],
                                  "carname": carnameController.text,
                                  "carprize": carprizeController.text,
                                  "caryear": caryearController.text,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text(' add data sucessfully')));
                                _cars = null;
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              print('not updated');
                            }
                          },
                          child: const Text("UpdateCars"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
