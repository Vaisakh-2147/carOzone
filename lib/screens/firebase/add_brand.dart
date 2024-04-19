import 'dart:io';

import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/admin_panel.dart';
import 'package:car_o_zone/screens/firebase/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddbrandScreen extends StatefulWidget {
  const AddbrandScreen({super.key});

  @override
  State<AddbrandScreen> createState() => _AddbrandScreenState();
}

class _AddbrandScreenState extends State<AddbrandScreen> {
  String? _carbrand;
  String? imageUrl;

  final carbrandController = TextEditingController();
  final carbrandnameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> _pickBrand() async {
    final imagePicker1 = ImagePicker();
    final pickedbrand =
        await imagePicker1.pickImage(source: ImageSource.gallery);

    setState(() {
      _carbrand = pickedbrand!.path;
    });
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
          child: Column(
            children: [
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
                    const SizedBox(
                      height: 15,
                    ),
                    subtitle('Carbrands', 13),
                    const SizedBox(height: 15),
                    customAddbrandPicker(image: _carbrand, onTap: _pickBrand),
                    if (_carbrand == null)
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
                    textFormFieldWidget(
                        controller: carbrandnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter brandname';
                          }
                          return null;
                        },
                        hintText: "brand name"),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_carbrand == null &&
                              carbrandnameController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Please select an image and enter a brand name'),
                            ));
                          } else if (_carbrand == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please select an image'),
                            ));
                          } else if (carbrandnameController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please enter the brand name'),
                            ));
                          } else {
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('carbrands');
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            try {
                              await referenceImageToUpload
                                  .putFile(File(_carbrand!));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                              await FirebaseFirestore.instance
                                  .collection('carBrands')
                                  .add({
                                'CarBrand': imageUrl,
                                "brandname":
                                    carbrandnameController.text.toLowerCase(),
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Data added successfully'),
                              ));
                              carbrandnameController.clear();
                              setState(() {
                                _carbrand = null;
                              });
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Text("Add brand"),
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
